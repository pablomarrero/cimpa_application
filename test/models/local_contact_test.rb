# == Schema Information
#
# Table name: local_contacts
#
#  id                             :integer          not null, primary key
#  administration_name            :string(255)
#  administration_place           :string(255)
#  administration_email           :string(255)
#  administration_phone           :string(255)
#  administration_cv_file_name    :string(255)
#  administration_cv_content_type :string(255)
#  administration_cv_file_size    :integer
#  administration_cv_updated_at   :datetime
#  presentation_id                :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#  administration_country         :string(255)
#  country_id                     :integer
#

require 'test_helper'

class LocalContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
