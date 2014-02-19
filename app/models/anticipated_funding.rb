class AnticipatedFunding < ActiveRecord::Base
	extend Enumerize
	belongs_to :presentation

  enumerize :anticipated_type, in: [:confirmed, :required, :provisional]

end
