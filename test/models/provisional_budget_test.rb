# == Schema Information
#
# Table name: provisional_budgets
#
#  id               :integer          not null, primary key
#  presentation_id  :integer
#  description      :string(255)
#  amount           :integer
#  provisional_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  currency_id      :integer
#

require 'test_helper'

class ProvisionalBudgetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
