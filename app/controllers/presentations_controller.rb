# encoding: UTF-8

class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:show, :edit, :update, :destroy, :pre_proposal, :final_proposal, :modification1_proposal, :modification2_proposal,
    :download_administration_cv, :download_scientific_cv, :download_tentative_schedule_file, :cancel_proposal]

  def generate_printable_proposal
    if current_user.has_any_role?(:admin, :scientific_officer)
      @evaluation1    = @presentation.evaluation1
      @evaluation2    = @presentation.evaluation2
      @synthesis1     = @presentation.synthesis1
      @synthesis2     = @presentation.synthesis2
    end
    pdf_files = ""
    content_type = "pdf"
    partial_path = "#{Rails.root}/tmp/partial_proposals/#{@presentation.id}_#{@presentation.acronym}.pdf" 
    full_path    = "#{Rails.root}/tmp/proposals/#{@presentation.id}_#{@presentation.acronym}.pdf" 

#    proposal_html = render_to_string "print_proposal", layout: 'print'
    proposal_html = (render "print_proposal", layout: 'print')[0]
    proposal_kit = PDFKit.new proposal_html, :page_size => 'A4', :orientation => 'portrait'
    proposal_kit.to_file partial_path
    pdf_files += partial_path

#    if @presentation.local_contact.administration_cv
#      administration_cv_path = @presentation.local_contact.administration_cv.path
#      pdf_files += " " + administration_cv_path
#    end
#
#    if @presentation.scientific_contact.scientific_cv
#      scientific_cv_path = @presentation.scientific_contact.scientific_cv.path
#      pdf_files += " " + scientific_cv_path
#    end

    options = "-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite"
    system "gs #{options} -sOutputFile=#{full_path} #{pdf_files}"
  end

  # GET /presentations
  # GET /presentations.json
  def index
    @proposals_search = Presentation.search params[:q]
    respond_to do |format|
      format.html do
        if current_user.has_any_role?(:admin, :scientific_officer)
          @presentations = @proposals_search.result.page params[:page]
          @preproposals = @proposals_search.result.where(proposal_state: [:pre_proposal]).where.not(pre_proposal_date: nil).page params[:page_preproposal]
          @finalproposals = @proposals_search.result.where(proposal_state: :final_proposal).page params[:page_preproposal]
          @revisionproposals = @proposals_search.result.where.not(evaluator1_id: nil).where.not(evaluator2_id: nil).page params[:page_revisionproposal]
        else
          @presentations = @proposals_search.result.where( user_id: current_user.id).page params[:page]
          @preproposals = @proposals_search.result.where(proposal_state: [:pre_proposal]).where.not(pre_proposal_date: nil).where( user_id: current_user.id).page params[:page_preproposal]
          @finalproposals = @proposals_search.result.where(proposal_state: [:final_proposal]).where( user_id: current_user.id).page params[:page_preproposal]
        end
      end
      format.xls do
        if current_user.has_role?(:admin)
          @presentations = Presentation.where(proposal_state: [:pre_proposal, :final_proposal]).all.map {|presentation| presentation.as_pre_proposal}
        elsif  current_user.has_role?(:scientific_officer)
          @presentations = Presentation.where(proposal_state: [:pre_proposal, :final_proposal]).all.map {|presentation| presentation.as_pre_proposal}
        else
          redirect_to presentations_url
        end
        render :xls => @presentations,
                       :columns => [  {:user => [:email]}, :id, :research_school_title, {:country => [:region, :name_en]}, :school_place, 
                                      {:local_contact => [:administration_name]}, {:scientific_contact => [:scientific_name]},
                                      :school_date_a_start_str, :school_date_a_finish_str, :school_date_b_start_str, :school_date_b_finish_str, 
                                      :comment],
                       :headers => [  'email du propriétaire', 'N° Projets', 'Titre', 'Région', 'Pays', 'Lieu', 'Local Responsable', 'Scientific Responsable', 
                                        'Date de début, option A', 'Date de fin, option A', 'Date de début, option B', 'Date de fin, option B',
                                        'Commentaires ou remarques', 'Evaluateur 1', 'Evaluateur 2', 'Synthèse']
      end
    end
  end

  def index_print
    if current_user.has_any_role?(:admin, :scientific_officer)
      @presentations = Presentation.all
      @preproposals = Presentation.where(proposal_state: [:pre_proposal]).where.not(pre_proposal_date: nil)
      @finalproposals = Presentation.where(proposal_state: :final_proposal)
      @revisionproposals = Presentation.where.not(evaluator1_id: nil).where.not(evaluator2_id: nil)
    else
      @presentations = Presentation.where( user_id: current_user.id)
      @preproposals = Presentation.where(proposal_state: [:pre_proposal]).where.not(pre_proposal_date: nil).where( user_id: current_user.id)
      @finalproposals = Presentation.where(proposal_state: [:final_proposal]).where( user_id: current_user.id)
    end
    render layout: 'print'
  end

  def export_zip
    redirect_to(presentations_url) unless current_user.has_any_role?(:admin, :scientific_officer)

    @presentations = Presentation.where(proposal_state: :final_proposal)
    @presentations.each do |presentation|
      @presentation = presentation
      generate_printable_proposal
    end
    tmp = "#{Rails.root}/tmp" 
    pdfs = Dir["#{tmp}/proposals/*.pdf"].map {|proposal| "proposals/#{File.basename(proposal)}"}

    zipfile_name = "#{tmp}/proposals.zip"

    File.delete(zipfile_name) if File.exists?(zipfile_name)

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      pdfs.each do |pdf|
        zipfile.add(pdf, tmp + '/' + pdf)
      end
    end
    send_file         zipfile_name,
      :filename    => "proposals.zip",
      :type        => 'zip',
      :disposition => 'attachment'
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show
  end

  def print_proposal
    @presentation  = Presentation.find(params[:id])
    render "print_proposal", layout: 'print'
  end

  def print_proposal_full
    @presentation = Presentation.find(params[:id])
    generate_printable_proposal
    presentations = "#{Rails.root}/tmp/proposals" 
    full_path = "#{Rails.root}/tmp/proposals/#{@presentation.id}_#{@presentation.acronym}.pdf" 

    send_file         full_path,
      :filename    => @presentation.acronym,
      :type        => 'pdf',
      :disposition => 'attachment'
  end

  def show_pre_proposal
    prep = Presentation.find(params[:id])
    @presentation = prep.as_pre_proposal
    render :show
  end

  # GET /presentations/new
  def new
    @presentation = Presentation.new
    @presentation.build_local_contact
    @presentation.build_scientific_contact
    @presentation.proposal_state = :proposal_fill
  end

  # GET /presentations/1/edit
  def edit
#    redirect_to @presentation, notice: 'Edition temporarily disabled.'
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = Presentation.new(presentation_params)
    @presentation.proposal_state = :primary_fill
    respond_to do |format|
      if @presentation.save
        @presentation.acronym = @presentation.school_date_a_start.strftime('%Y') + '-' + (@presentation.country.try(:name_en)||'') + '-' + 
                                (@presentation.country.try(:code)||'') + '-' + @presentation.id.to_s
        @presentation.save
        format.html { redirect_to @presentation, notice: 'Presentation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @presentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    respond_to do |format|
      if @presentation.update(presentation_params)
        @presentation.acronym = @presentation.school_date_a_start.strftime('%Y') + '-' + (@presentation.country.try(:name_en)||'') + '-' + 
                                (@presentation.country.try(:code)||'') + '-' + @presentation.id.to_s
        @presentation.save
        format.html { redirect_to @presentation, notice: 'Presentation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentations/1
  # DELETE /presentations/1.json
  def destroy
    @presentation.destroy
    respond_to do |format|
      format.html { redirect_to presentations_url }
      format.json { head :no_content }
    end
  end

  def download_administration_cv
    send_file @presentation.local_contact.administration_cv.path,
      :filename => @presentation.local_contact.administration_cv_file_name,
      :type => @presentation.local_contact.administration_cv_content_type,
      :disposition => 'attachment'
  end
  def download_scientific_cv
    send_file @presentation.scientific_contact.scientific_cv.path,
      :filename => @presentation.scientific_contact.scientific_cv_file_name,
      :type => @presentation.scientific_contact.scientific_cv_content_type,
      :disposition => 'attachment'
  end
  def download_tentative_schedule_file
    send_file @presentation.tentative_schedule_file.path,
      :filename => @presentation.tentative_schedule_file_file_name,
      :type => @presentation.tentative_schedule_file_content_type,
      :disposition => 'attachment'
  end

  def pre_proposal
    if DateTime.now < Date.strptime('20140815','%Y%m%d')
      @presentation.pre_proposal_date = DateTime.now
      @presentation.proposal_state = :pre_proposal 
      respond_to do |format|
        if @presentation.save
          format.html { redirect_to @presentation, notice: 'OK.' }
          format.json { render action: 'show', status: :created, location: @presentation }
        else
          format.html { render action: 'new' }
          format.json { render json: @presentation.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to presentations_url, notice: 'Pre-proposals closed.'
    end
  end
  
  def final_proposal
    @presentation.final_proposal_date = DateTime.now
    @presentation.proposal_state = :final_proposal 
    respond_to do |format|
      if @presentation.save
        format.html { redirect_to @presentation, notice: 'OK.' }
        format.json { render action: 'show', status: :created, location: @presentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  def modification1_proposal
    @presentation.modification1_date = DateTime.now
    respond_to do |format|
      if @presentation.save
        format.html { redirect_to @presentation, notice: 'OK.' }
        format.json { render action: 'show', status: :created, location: @presentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end
  def modification2_proposal
    @presentation.modification2_date = DateTime.now
    respond_to do |format|
      if @presentation.save
        format.html { redirect_to @presentation, notice: 'OK.' }
        format.json { render action: 'show', status: :created, location: @presentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end
  def req_modification1_proposal
    @presentation.modification1_req_date = DateTime.now
    respond_to do |format|
      if @presentation.save
        format.html { redirect_to @presentation, notice: 'OK.' }
        format.json { render action: 'show', status: :created, location: @presentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end
  def req_modification2_proposal
    @presentation.modification2_req_date = DateTime.now
    respond_to do |format|
      if @presentation.save
        format.html { redirect_to @presentation, notice: 'OK.' }
        format.json { render action: 'show', status: :created, location: @presentation }
      else
        format.html { render action: 'new' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end
  def cancel_proposal
    @presentation.cancel_date = DateTime.now
    @presentation.save
    redirect_to action: :index
    
  end
  private
    def verify_pre_proposal_fields
      true
    end
    def verify_final_proposal_fields
      true
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = Presentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def presentation_params
      params.require(:presentation).permit(:acronym, :country_id, :similar_project, :user_id, :completely_read, :tentative_schedule_file, 
        :research_school_title, :project_type, :subject_clasification, :school_place, :school_country, :school_date_a_start, :school_date_a_finish, 
        :school_date_b_start, :school_date_b_finish, :scientific_content, :members_of_scientific_committee, :comment, 
        :members_of_local_committee, :local_institution_description, :motivation, 
        :related_scientific_work, :infrastructure, :tentative_schedule, 
        :course1, :course2, :course3, :course4, :course5, :course6, 
        :women_percentage_scientific, :women_percentage_local, :women_percentage_course, 
        :how_much_cimpa, :how_much_cimpa_percentage, :young_people, :average_time_scientific, 
        :day_time_scientific, :confirmation_completely_read,   
        scientific_contact_attributes: [:id, :country_id, :scientific_name, :scientific_place, :scientific_country,
        :scientific_email, :scientific_phone, :scientific_cv],
        local_contact_attributes: [:id, :country_id, :administration_name, :administration_place, :administration_country,
        :administration_email, :administration_phone, :administration_cv],
        provisional_budgets_attributes: [:_destroy, :id, :description, :currency_id, :amount, :provisional_type, :presentation_id],
        anticipated_fundings_attributes: [:_destroy, :id, :description, :currency_id, :amount, :anticipated_type, :presentation_id])
    end
end
