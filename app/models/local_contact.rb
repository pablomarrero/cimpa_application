# == Schema Information
#
# Table name: local_contacts
#
#  id                             :integer          not null, primary key
#  administration_name            :string(255)
#  administration_place           :string(255)
#  administration_email           :string(255)
#  administration_phone           :string(255)
#  administration_cv_file_name    :string(255)
#  administration_cv_content_type :string(255)
#  administration_cv_file_size    :integer
#  administration_cv_updated_at   :datetime
#  presentation_id                :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#  administration_country         :string(255)
#  country_id                     :integer
#

class LocalContact < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :country

  has_attached_file :administration_cv, 
                    :url => "/assets/presentation/:id/administration_cv/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/administration_cv/:basename.:extension"
  validates_attachment  :administration_cv, 
                        :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'},
                        :size => { :in => 0..10.megabytes }
  validates :administration_name, presence: true, if: :final_proposal?
  validates :administration_place, presence: true, if: :final_proposal?
  validates :administration_email, presence: true, if: :final_proposal?
  validates :administration_phone, presence: true, if: :final_proposal?
#  validates :administration_cv, presence: true, if: :final_proposal?
  def final_proposal?
    !self.presentation.nil? && self.presentation.proposal_state == 'final_proposal'
  end

end
