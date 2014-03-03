class AddSchoolCountryToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :school_country, :string
  end
end
