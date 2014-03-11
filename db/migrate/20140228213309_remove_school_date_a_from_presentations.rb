class RemoveSchoolDateAFromPresentations < ActiveRecord::Migration
  def change
    remove_column :presentations, :school_date_a, :string
  end
end
