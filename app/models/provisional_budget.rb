class ProvisionalBudget < ActiveRecord::Base
	extend Enumerize

  belongs_to :presentation
  belongs_to :currency
  enumerize :provisional_type, in: [:confirmed, :required, :provisional]
end
