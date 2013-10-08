require 'spec_helper'

describe PeopleController do

	# login
	before (:each) do
    	@user = FactoryGirl.create(:user)
    	sign_in @user
  	end

	describe "GET index" do
		it "assigns @people" do
			person = FactoryGirl.create(:person)
			get :index
			expect(assigns[:people]).to eq([person])
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
		end
	end

end
