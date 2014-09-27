# == Schema Information
#
# Table name: people
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  birth_date          :date
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

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
