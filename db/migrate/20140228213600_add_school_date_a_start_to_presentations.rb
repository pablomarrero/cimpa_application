class AddSchoolDateAStartToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :school_date_a_start, :date
  end
end
