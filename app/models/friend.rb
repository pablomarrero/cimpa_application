# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Friend < ActiveRecord::Base
  validates :person_id, presence: true
  validates :friend_id, presence: true
  belongs_to :person, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :friend, :class_name => "Person", :foreign_key => "friend_id"

end
