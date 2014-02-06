class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.boolean :similar_project
      t.references :user, index: true
      t.boolean :completely_read
      t.string :research_school_title
      t.string :project_type
      t.integer :subject_clasification
      t.string :school_place
      t.string :school_date_a
      t.string :school_date_b
      t.text :scientific_content
      t.text :members_of_scientific_committee
      t.text :members_of_local_committee
      t.text :local_institution_description
      t.text :motivation
      t.text :related_scientific_work
      t.text :infrastructure
      t.text :courses
      t.text :tentative_schedule
      t.integer :women_percentage_scientific
      t.integer :women_percentage_local
      t.integer :women_percentage_course
      t.float :how_much_cimpa
      t.integer :how_much_cimpa_percentage
      t.integer :young_people
      t.float :average_time_scientific
      t.integer :day_time_scientific
      t.boolean :confirmation_completely_read

      t.timestamps
    end
  end
end
