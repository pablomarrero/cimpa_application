class AddSchoolDateBFinishToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :school_date_b_finish, :date
  end
end
