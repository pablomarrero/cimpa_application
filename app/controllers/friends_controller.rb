class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /friends
  # GET /friends.json
  def index
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @friends = Friend.all
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
  end

  # GET /friends/new
  def new
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
  end

  # POST /friends
  # POST /friends.json
  def create
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
        format.json { render action: 'show', status: :created, location: @friend }
      else
        format.html { render action: 'new' }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    return redirect_to(presentations_url) unless current_user.has_any_role?(:admin) 
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:person_id, :person_id)
    end
end
