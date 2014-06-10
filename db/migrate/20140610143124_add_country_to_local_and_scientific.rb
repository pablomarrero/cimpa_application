class AddCountryToLocalAndScientific < ActiveRecord::Migration
  def change
  	add_column :scientific_contacts, :scientific_country, :string
  	add_column :local_contacts, :administration_country, :string
  end
end
