class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:show, :edit, :update, :destroy, :pre_proposal, :final_proposal, 
    :download_administration_cv, :download_scientific_cv, :download_tentative_schedule_file]

  # GET /presentations
  # GET /presentations.json
  def index
    respond_to do |format|
      format.html do
        if current_user.has_role?(:admin)
          @presentations = Presentation.all.page params[:page]
        elsif  current_user.has_role?(:scientific_officer)
          @presentations = Presentation.where(proposal_state: [:pre_proposal, :final_proposal]).page params[:page]
        else
          @presentations = Presentation.where( user_id: current_user.id).page params[:page]
        end
      end
      format.xls do
        if current_user.has_role?(:admin)
          @presentations = Presentation.all
        elsif  current_user.has_role?(:scientific_officer)
          @presentations = Presentation.where(proposal_state: [:pre_proposal, :final_proposal])
        else
          @presentations = Presentation.where( user_id: current_user.id)
        end
        render :xls => @presentations,
                       :columns => [  {:user => [:email]}, :id, :research_school_title, {:country => [:region, :name_fr]}, :school_place, 
                                      {:local_contact => [:administration_name]}, {:scientific_contact => [:scientific_name]},
                                      :school_date_a_start_str, :school_date_a_finish_str, :school_date_b_start_str, :school_date_b_finish_str, 
                                      :comment],
                       :headers => [  'Nom du propriétaire', 'N° Projets', 'Titre', 'Région', 'Pays', 'Lieu', 'Local Responsable', 'Scientific Responsable', 
                                        'Date de début, option A', 'Date de fin, option A', 'Date de début, option B', 'Date de fin, option B',
                                        'Commentaires ou remarques']
      end
    end
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show
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
    redirect_to @presentation, notice: 'Edition temporarily disabled.'
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = Presentation.new(presentation_params)
    @presentation.proposal_state = :primary_fill
    respond_to do |format|
      if @presentation.save
        @presentation.acronym = @presentation.school_date_a_start.strftime('%Y') + '-' + @presentation.country.try(:name_fr) + '-' + 
                                @presentation.country.try(:code) + '-' + @presentation.id.to_s
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
        @presentation.acronym = @presentation.school_date_a_start.strftime('%Y') + '-' + @presentation.country.try(:name_fr) + '-' + 
                                @presentation.country.try(:code) + '-' + @presentation.id.to_s
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
      params.require(:presentation).permit(:country_id, :similar_project, :user_id, :completely_read, :tentative_schedule_file, 
        :research_school_title, :project_type, :subject_clasification, :school_place, :school_country, :school_date_a_start, :school_date_a_finish, 
        :school_date_b_start, :school_date_b_finish, :scientific_content, :members_of_scientific_committee, :comment, 
        :members_of_local_committee, :local_institution_description, :motivation, 
        :related_scientific_work, :infrastructure, :tentative_schedule, 
        :course1, :course2, :course3, :course4, :course5, :course6, 
        :women_percentage_scientific, :women_percentage_local, :women_percentage_course, 
        :how_much_cimpa, :how_much_cimpa_percentage, :young_people, :average_time_scientific, 
        :day_time_scientific, :confirmation_completely_read,   
        scientific_contact_attributes: [:id, :scientific_name, :scientific_place, :scientific_country,
        :scientific_email, :scientific_phone, :scientific_cv],
        local_contact_attributes: [:id, :administration_name, :administration_place, :administration_country,
        :administration_email, :administration_phone, :administration_cv],
        provisional_budgets_attributes: [:_destroy, :id, :description, :currency_id, :amount, :provisional_type, :presentation_id],
        anticipated_fundings_attributes: [:_destroy, :id, :description, :currency_id, :amount, :anticipated_type, :presentation_id])
    end
end
