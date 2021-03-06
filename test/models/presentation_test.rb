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

require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
