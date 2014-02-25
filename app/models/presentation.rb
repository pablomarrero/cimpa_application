class Presentation < ActiveRecord::Base
  extend Enumerize
  has_paper_trail

  belongs_to :user
  enumerize :project_type, in: [:fundamental, :applied, :mixed]
  enumerize :proposal_state, in: [:primary_fill, :pre_proposal, :final_proposal]

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


  validates :similar_project, presence: true, if: :pre_proposal? || :final_proposal?
  validates :completely_read, presence: true, if: :pre_proposal? || :final_proposal?
  validates :research_school_title, presence: true, if: :pre_proposal? || :final_proposal?
  validates :project_type, presence: true, if: :pre_proposal? || :final_proposal?
  validates :subject_clasification, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_place, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_a, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_b, presence: true, if: :pre_proposal? || :final_proposal?
  validates :scientific_content, presence: true, if: :pre_proposal? || :final_proposal?
  validates :members_of_scientific_committee, presence: true, if: :pre_proposal? || :final_proposal?
  validates :motivation, presence: true, if: :pre_proposal? || :final_proposal?
  validates :confirmation_completely_read, presence: true, if: :pre_proposal? || :final_proposal?

  validates :members_of_local_committee, presence: true, if: :final_proposal?
  validates :local_institution_description, presence: true, if: :final_proposal?
  validates :related_scientific_work, presence: true, if: :final_proposal?
  validates :infrastructure, presence: true, if: :final_proposal?
  validates :courses, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?
  validates :women_percentage_scientific, presence: true, if: :final_proposal?
  validates :women_percentage_local, presence: true, if: :final_proposal?
  validates :women_percentage_course, presence: true, if: :final_proposal?
  validates :how_much_cimpa, presence: true, if: :final_proposal?
  validates :how_much_cimpa_percentage, presence: true, if: :final_proposal?
  validates :young_people, presence: true, if: :final_proposal?
  validates :average_time_scientific, presence: true, if: :final_proposal?
  validates :day_time_scientific, presence: true, if: :final_proposal?
  validates :administration_name, presence: true, if: :final_proposal?
  validates :administration_place, presence: true, if: :final_proposal?
  validates :administration_email, presence: true, if: :final_proposal?
  validates :administration_phone, presence: true, if: :final_proposal?
  validates :administration_cv, presence: true, if: :final_proposal?
  validates :scientific_name, presence: true, if: :final_proposal?
  validates :scientific_place, presence: true, if: :final_proposal?
  validates :scientific_email, presence: true, if: :final_proposal?
  validates :scientific_phone, presence: true, if: :final_proposal?
  validates :scientific_cv, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?

  def final_proposal?
    self.proposal_state == 'final_proposal'
  end
  def pre_proposal?
    self.proposal_state == 'pre_proposal'
  end

end
