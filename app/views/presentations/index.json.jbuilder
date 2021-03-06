json.array!(@presentations) do |presentation|
  json.extract! presentation, :similar_project, :user_id, :completely_read, :research_school_title, :project_type, :subject_clasification, :school_place, :school_country, :school_date_a_start, :school_date_a_finish, :school_date_b_start, :school_date_b_finish, :scientific_content, :members_of_scientific_committee, :members_of_local_committee, :local_institution_description, :motivation, :related_scientific_work, :infrastructure, :courses, :tentative_schedule, :women_percentage_scientific, :women_percentage_local, :women_percentage_course, :how_much_cimpa, :how_much_cimpa_percentage, :young_people, :average_time_scientific, :day_time_scientific, :confirmation_completely_read
  json.url presentation_url(presentation, format: :json)
end
