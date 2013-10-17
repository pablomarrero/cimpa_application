require 'spec_helper'

describe PeopleController do

	# login
	before (:each) do
    	@user = create(:user)
    	sign_in @user
  	end

	describe "GET index" do
		it "assigns @people" do
			person = create(:person)
			get :index
			expect(assigns[:people]).to eq([person])
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
		end
	end

	describe "POST create" do 
		context "valid params" do 

			it "creates new person" do				
				expect{ post :create, person: attributes_for(:person)}.to change(Person, :count).by(1)
			end

			it "assigns created person to @person" do
				post :create, person: attributes_for(:person)
				expect(assigns(:person)).to be_a(Person)
				expect(assigns(:person)).to be_persisted
			end

			it "redirects to show page" do 
				post :create, person: attributes_for(:person)
				expect(response).to redirect_to(person_url(Person.last))
			end

		end

		context "invalid params" do
			before(:each) do 
				post :create, person: attributes_for(:person, first_name: nil)
			end
			it "doesn't persist the model" do
				expect(assigns(:person)).to be_a_new(Person)
			end
			it "re-renders 'new' template" do				
				expect(response).to render_template("new")
			end
		end
	end

	describe "PUT update" do
		context "valid params" do 
			let(:person){create(:person)}

			it "updates requested person" do				
				Person.any_instance.should_receive(:update).with({"first_name" => "new first name"})
				put :update, id: person.id, person: {first_name: "new first name"}
			end

			it "assigns updated person to @person" do
				put :update, id: person.id, person: attributes_for(:person)
				expect(assigns(:person)).to eq(person)
			end

			it "redirects to show page" do 
				put :update, id: person.id, person: attributes_for(:person)
				expect(response).to redirect_to(person_url(person.id))
			end

		end

		context "invalid params" do 
			let(:person){create(:person)}

			before(:each) do
				put :update, id: person.id, person: attributes_for(:person, first_name: nil)
			end
			
			it "adds errors to the model" do				
				expect(assigns(:person).errors).not_to be_empty
			end

			it "re-renders 'edit' template" do 				
				expect(response).to render_template("edit")
			end
		end
	end


	describe "DELETE destroy" do
		before(:each) do
			@person = create(:person)
		end

	    it "destroys the requested person" do	      
	      expect { delete :destroy, :id => @person.id }.to change(Person, :count).by(-1)
	    end

	    it "redirects to the people list" do	      
	      delete :destroy, :id => @person.id
	      expect(response).to redirect_to(people_url)
	    end
  end

end
