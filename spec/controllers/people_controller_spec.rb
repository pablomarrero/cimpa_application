require 'spec_helper'

describe PeopleController do

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
