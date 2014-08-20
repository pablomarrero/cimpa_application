class ScientificContact < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :country
  
  has_attached_file :scientific_cv, 
                    :url => "/assets/presentation/:id/scientific_cv/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/scientific_cv/:basename.:extension"
  validates_attachment  :scientific_cv, 
                        :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'},
                        :size => { :in => 0..10.megabytes }
  validates_attachment_presence :scientific_cv

  validates :scientific_name, presence: true, if: :final_proposal?
  validates :scientific_place, presence: true, if: :final_proposal?
  validates :scientific_email, presence: true, if: :final_proposal?
  validates :scientific_phone, presence: true, if: :final_proposal?
#  validates :scientific_cv, presence: true, if: :final_proposal?
  def final_proposal?
    !self.presentation.nil? && self.presentation.proposal_state == 'final_proposal'
  end
end
