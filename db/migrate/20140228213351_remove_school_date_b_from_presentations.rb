class RemoveSchoolDateBFromPresentations < ActiveRecord::Migration
  def change
    remove_column :presentations, :school_date_b, :string
  end
end
