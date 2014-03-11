class AddSchoolDateAFinishToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :school_date_a_finish, :date
  end
end
