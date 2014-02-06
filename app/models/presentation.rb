class Presentation < ActiveRecord::Base
  extend Enumerize

  belongs_to :user
  enumerize :project_type, in: [:fundamental, :applied, :mixed]
end
