class AnticipatedFunding < ActiveRecord::Base
	extend Enumerize
	belongs_to :presentation
	belongs_to :currency

  enumerize :anticipated_type, in: [:confirmed, :required, :provisional]

end