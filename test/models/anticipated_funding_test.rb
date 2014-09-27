# == Schema Information
#
# Table name: anticipated_fundings
#
#  id               :integer          not null, primary key
#  presentation_id  :integer
#  description      :string(255)
#  amount           :integer
#  anticipated_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  currency_id      :integer
#

require 'test_helper'

class AnticipatedFundingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
