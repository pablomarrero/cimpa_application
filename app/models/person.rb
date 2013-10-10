class Person < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true

  has_many  :friends, :class_name => "Friend", :foreign_key => "person_id"
  accepts_nested_attributes_for :friends, :reject_if => :all_blank, :allow_destroy => true
  has_many  :people, through: :friends

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :default_url => ":style/missing.png"

  has_paper_trail

  def name
  	[first_name, last_name].join " "
  end
  
end
