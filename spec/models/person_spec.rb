# == Schema Information
#
# Table name: people
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  birth_date          :date
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

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
