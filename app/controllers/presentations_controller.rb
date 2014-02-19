class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]

  # GET /presentations
  # GET /presentations.json
  def index
    if current_user.has_role? :admin
      @presentations = Presentation.page params[:page]
    else
      @presentations = Presentation.where( user_id: current_user.id).page params[:page]
    end
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show
  end

  # GET /presentations/new
  def new
    @presentation = Presentation.new
  end

  # GET /presentations/1/edit
  def edit
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = Presentation.new(presentation_params)

    respond_to do |format|
      if @presentation.save
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
    send_file @presentation.administration_cv.path,
      :filename => @presentation.administration_cv_file_name,
      :type => @presentation.administration_cv_content_type,
      :disposition => 'attachment'
  end
  def download_scientific_cv
    send_file @presentation.scientific_cv.path,
      :filename => @presentation.scientific_cv_file_name,
      :type => @presentation.scientific_cv_content_type,
      :disposition => 'attachment'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = Presentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def presentation_params
      params.require(:presentation).permit(:similar_project, :user_id, :completely_read, 
        :research_school_title, :project_type, :subject_clasification, :school_place, :school_date_a, 
        :school_date_b, :scientific_content, :members_of_scientific_committee, 
        :members_of_local_committee, :local_institution_description, :motivation, 
        :related_scientific_work, :infrastructure, :courses, :tentative_schedule, 
        :women_percentage_scientific, :women_percentage_local, :women_percentage_course, 
        :how_much_cimpa, :how_much_cimpa_percentage, :young_people, :average_time_scientific, 
        :day_time_scientific, :confirmation_completely_read, :administration_name, :administration_place,
        :administration_email, :administration_phone, :administration_cv, :scientific_name, :scientific_place,
        :scientific_email, :scientific_phone, :scientific_cv, 
        provisional_budgets_attributes: [:id, :description, :amount, :provisional_type, :presentation_id],
        anticipated_fundings_attributes: [:id, :description, :amount, :anticipated_type, :presentation_id])
    end
end
