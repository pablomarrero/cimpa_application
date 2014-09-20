# == Schema Information
#
# Table name: scientific_contacts
#
#  id                         :integer          not null, primary key
#  scientific_name            :string(255)
#  scientific_place           :string(255)
#  scientific_email           :string(255)
#  scientific_phone           :string(255)
#  string                     :string(255)
#  scientific_cv_file_name    :string(255)
#  scientific_cv_content_type :string(255)
#  scientific_cv_file_size    :integer
#  scientific_cv_updated_at   :datetime
#  presentation_id            :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  scientific_country         :string(255)
#  country_id                 :integer
#

require 'test_helper'

class ScientificContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
