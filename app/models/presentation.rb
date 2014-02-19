class Presentation < ActiveRecord::Base
  extend Enumerize

  belongs_to :user
  enumerize :project_type, in: [:fundamental, :applied, :mixed]

  has_attached_file :administration_cv, 
                    :url => "/assets/presentation/:id/administration_cv/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/administration_cv/:basename.:extension"
  validates_attachment :administration_cv, :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'}

  has_attached_file :scientific_cv, 
                    :url => "/assets/presentation/:id/scientific_cv/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/scientific_cv/:basename.:extension"
  validates_attachment :scientific_cv, :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'}

  has_many :provisional_budgets
  accepts_nested_attributes_for :provisional_budgets, :reject_if => :all_blank, :allow_destroy => true
  has_many :anticipated_fundings
  accepts_nested_attributes_for :anticipated_fundings, :reject_if => :all_blank, :allow_destroy => true
end
