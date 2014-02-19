class ProvisionalBudget < ActiveRecord::Base
	extend Enumerize

  belongs_to :presentation
  enumerize :provisional_type, in: [:confirmed, :required, :provisional]
end
