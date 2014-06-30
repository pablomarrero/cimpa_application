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
  validates :administration_cv, presence: true, if: :final_proposal?
  def final_proposal?
    !self.presentation.nil? && self.presentation.proposal_state == 'final_proposal'
  end

end
