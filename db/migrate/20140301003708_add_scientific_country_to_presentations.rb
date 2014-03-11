class AddScientificCountryToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :scientific_country, :string
  end
end
