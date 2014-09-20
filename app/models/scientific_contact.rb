# == Schema Information
#
# Table name: scientific_contacts
#
#  id                         :integer          not null, primary key
#  scientific_name            :string(255)
#  scientific_place           :string(255)
#  scientific_email           :string(255)
#  scientific_phone           :string(255)
#  string                     :string(255)
#  scientific_cv_file_name    :string(255)
#  scientific_cv_content_type :string(255)
#  scientific_cv_file_size    :integer
#  scientific_cv_updated_at   :datetime
#  presentation_id            :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  scientific_country         :string(255)
#  country_id                 :integer
#

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
