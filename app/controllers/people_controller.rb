class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /people
  # GET /people.json
  def index
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
    @people = Person.order(:last_name).page params[:page]
  end

  # GET /people/1
  # GET /people/1.json
  def show
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
  end

  # GET /people/new
  def new
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
    @person = Person.new
    @people = Person.all
  end

  # GET /people/1/edit
  def edit
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
    @people = Person.all
  end

  # POST /people
  # POST /people.json
  def create
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    return redirect_to('/') unless current_user.has_any_role?(:admin) 
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :birth_date, :avatar, friends_attributes: [ :id, :friend_id, :person_id, :_destroy])
    end
end
