require 'spec_helper'

describe Person do
	it "has a valid factory" do
		expect(FactoryGirl.create(:person)).to be_valid
	end
	it "is invalid without first name" do
		expect(FactoryGirl.build(:person, first_name: nil)).to be_invalid
	end
	it "is invalid without last name" do 
		expect(FactoryGirl.build(:person, last_name: nil)).to be_invalid
	end
	it "is invalid without birth date" do 
		expect(FactoryGirl.build(:person, birth_date: nil)).to be_invalid
	end

	describe ".name" do
		it "should return full name" do
			person = FactoryGirl.create(:person, first_name: "John", last_name: "Doe")
			expect(person.name).to eq("John Doe")
		end
	end

end