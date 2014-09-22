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

class ProvisionalBudget < ActiveRecord::Base
	extend Enumerize

  belongs_to :presentation
  belongs_to :currency
  enumerize :provisional_type, in: [:confirmed, :required, :provisional]
end
