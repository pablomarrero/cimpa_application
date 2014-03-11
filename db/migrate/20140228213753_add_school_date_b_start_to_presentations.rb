class AddSchoolDateBStartToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :school_date_b_start, :date
  end
end
