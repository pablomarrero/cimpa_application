# == Schema Information
#
# Table name: presentations
#
#  id                                   :integer          not null, primary key
#  similar_project                      :boolean
#  user_id                              :integer
#  completely_read                      :boolean
#  research_school_title                :string(255)
#  project_type                         :string(255)
#  subject_clasification                :string(255)
#  school_place                         :string(255)
#  scientific_content                   :text
#  members_of_scientific_committee      :text
#  members_of_local_committee           :text
#  local_institution_description        :text
#  motivation                           :text
#  related_scientific_work              :text
#  infrastructure                       :text
#  course1                              :text
#  tentative_schedule                   :text
#  women_percentage_scientific          :integer
#  women_percentage_local               :integer
#  women_percentage_course              :integer
#  how_much_cimpa                       :float
#  how_much_cimpa_percentage            :integer
#  young_people                         :integer
#  average_time_scientific              :float
#  day_time_scientific                  :integer
#  confirmation_completely_read         :boolean
#  created_at                           :datetime
#  updated_at                           :datetime
#  proposal_state                       :string(255)
#  pre_proposal_date                    :datetime
#  final_proposal_date                  :datetime
#  comment                              :text
#  course2                              :text
#  course3                              :text
#  course4                              :text
#  course5                              :text
#  course6                              :text
#  school_date_a_start                  :date
#  school_date_a_finish                 :date
#  school_date_b_start                  :date
#  school_date_b_finish                 :date
#  school_country                       :string(255)
#  scientific_country                   :string(255)
#  tentative_schedule_file_file_name    :string(255)
#  tentative_schedule_file_content_type :string(255)
#  tentative_schedule_file_file_size    :integer
#  tentative_schedule_file_updated_at   :datetime
#  country_id                           :integer
#  acronym                              :string(255)
#  evaluation1_id                       :integer
#  evaluation2_id                       :integer
#  evaluator1_id                        :integer
#  evaluator2_id                        :integer
#  cancel_date                          :date
#  modification1_date                   :date
#  modification2_date                   :date
#  synthesis1_id                        :integer
#  synthesis2_id                        :integer
#  modification1_req_date               :date
#  modification2_req_date               :date
#

class Presentation < ActiveRecord::Base
  extend Enumerize
  has_paper_trail

  belongs_to :user
  belongs_to :country 

  belongs_to :evaluation1, class_name: 'Evaluation', foreign_key: 'evaluation1_id'
  belongs_to :evaluation2, class_name: 'Evaluation', foreign_key: 'evaluation2_id'

  belongs_to :evaluator1, class_name: 'User', foreign_key: 'evaluator1_id'
  belongs_to :evaluator2, class_name: 'User', foreign_key: 'evaluator2_id'

  belongs_to :synthesis1, class_name: 'Synthesis', foreign_key: 'synthesis1_id'
  belongs_to :synthesis2, class_name: 'Synthesis', foreign_key: 'synthesis2_id'

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
