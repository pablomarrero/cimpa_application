class Presentation < ActiveRecord::Base
  extend Enumerize
  has_paper_trail

  belongs_to :user
  belongs_to :country 

  has_one :local_contact
  accepts_nested_attributes_for :local_contact, :reject_if => :all_blank, :allow_destroy => true
  
  has_one :scientific_contact
  accepts_nested_attributes_for :scientific_contact, :reject_if => :all_blank, :allow_destroy => true

  enumerize :project_type, in: [:fundamental, :applied, :mixed]
  enumerize :proposal_state, in: [:primary_fill, :pre_proposal, :final_proposal]
  enumerize :subject_clasification, in: ['00','01','03','05','06','08','11','12', '13','14','15','16','17','18','19','20','22','26','28','30','31','32','33', '34','35','37','39','40','41','42','43','44','45','46','47','49','51','52','53','54','55','57','58','60','62','65','68','70','74','76', '78','80','81','82','83','85','86','90','91','92','93','94','97']

  has_many :provisional_budgets
  accepts_nested_attributes_for :provisional_budgets, :reject_if => :all_blank, :allow_destroy => true

  has_many :anticipated_fundings
  accepts_nested_attributes_for :anticipated_fundings, :reject_if => :all_blank, :allow_destroy => true

  has_attached_file :tentative_schedule_file, 
                    :url => "/assets/presentation/:id/tentative_schedule_file/:basename.:extension",
                    :path => ":rails_root/public/assets/presentation/:id/tentative_schedule_file/:basename.:extension"
  validates_attachment  :tentative_schedule_file, 
                        :content_type => {:content_type => 'application/pdf' , :message => 'Only pdf'},
                        :size => { :in => 0..10.megabytes }

#  validates :similar_project, presence: true, if: :pre_proposal? || :final_proposal?
  validates :completely_read, presence: true, if: :pre_proposal? || :final_proposal?
  validates :research_school_title, presence: true, if: :pre_proposal? || :final_proposal?
  validates :project_type, presence: true, if: :pre_proposal? || :final_proposal?
  validates :subject_clasification, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_place, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_a_start, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_a_finish, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_b_start, presence: true, if: :pre_proposal? || :final_proposal?
  validates :school_date_b_finish, presence: true, if: :pre_proposal? || :final_proposal?
  validates :scientific_content, presence: true, if: :pre_proposal? || :final_proposal?
  validates :members_of_scientific_committee, presence: true, if: :pre_proposal? || :final_proposal?
  validates :motivation, presence: true, if: :pre_proposal? || :final_proposal?
  validates :confirmation_completely_read, presence: true, if: :pre_proposal? || :final_proposal?

  validates :members_of_local_committee, presence: true, if: :final_proposal?
  validates :local_institution_description, presence: true, if: :final_proposal?
  validates :related_scientific_work, presence: true, if: :final_proposal?
  validates :infrastructure, presence: true, if: :final_proposal?
  validates :tentative_schedule, presence: true, if: :final_proposal?
  validates :women_percentage_scientific, presence: true, if: :final_proposal?
  validates :women_percentage_local, presence: true, if: :final_proposal?
  validates :women_percentage_course, presence: true, if: :final_proposal?
  validates :how_much_cimpa, presence: true, if: :final_proposal?
  validates :how_much_cimpa_percentage, presence: true, if: :final_proposal?
  validates :young_people, presence: true, if: :final_proposal?
  validates :average_time_scientific, presence: true, if: :final_proposal?
  validates :day_time_scientific, presence: true, if: :final_proposal?

  def self.by_region
    self.all.sort_by {|x| (x.country && x.country.region)||''}
  end

  def final_proposal?
    self.proposal_state == 'final_proposal'
  end

  def pre_proposal?
    self.proposal_state == 'pre_proposal'
  end

  def school_date_a_start_str
    school_date_a_start.strftime('%d-%m-%Y')
  end

  def school_date_a_finish_str
    school_date_a_finish.strftime('%d-%m-%Y')
  end

  def school_date_b_start_str
    school_date_b_start.strftime('%d-%m-%Y')
  end 

  def school_date_b_finish_str
    school_date_b_finish.strftime('%d-%m-%Y')
  end

  def as_pre_proposal
    if self.pre_proposal_date
      self.version_at(self.pre_proposal_date)
    else
      nil
    end
  end
end
