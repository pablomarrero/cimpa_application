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

class AnticipatedFunding < ActiveRecord::Base
	extend Enumerize
	belongs_to :presentation
	belongs_to :currency

  enumerize :anticipated_type, in: [:confirmed, :required, :provisional]

end
