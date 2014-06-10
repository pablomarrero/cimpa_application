class RemoveCountryToPresentation < ActiveRecord::Migration
  def change
  	#remove_column :presentations, :scientific_country, :string
  	remove_column :presentations, :administration_country, :string
  end
end
