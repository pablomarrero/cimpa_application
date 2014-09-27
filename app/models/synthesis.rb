# == Schema Information
#
# Table name: syntheses
#
#  id         :integer          not null, primary key
#  date_due   :date
#  user_id    :integer
#  summary    :text
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

class Synthesis < ActiveRecord::Base
end
