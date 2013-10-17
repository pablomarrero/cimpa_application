require 'spec_helper'

describe Person do
	it "has a valid factory" do
		expect(create(:person)).to be_valid
	end
	it "is invalid without first name" do
		expect(build(:person, first_name: nil)).to be_invalid
	end
	it "is invalid without last name" do 
		expect(build(:person, last_name: nil)).to be_invalid
	end
	it "is invalid without birth date" do 
		expect(build(:person, birth_date: nil)).to be_invalid
	end	

	describe ".name" do
		it "should return full name" do
			person = create(:person, first_name: "John", last_name: "Doe")
			expect(person.name).to eq("John Doe")
		end
	end

end