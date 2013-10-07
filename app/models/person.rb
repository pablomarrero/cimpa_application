class Person < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true

  has_many  :friends, :class_name => "Friend", :foreign_key => "person_id"
  accepts_nested_attributes_for :friends, :reject_if => :all_blank, :allow_destroy => true
  has_many  :people, through: :friends

end
