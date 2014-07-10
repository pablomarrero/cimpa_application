class AddCountryToContacts < ActiveRecord::Migration
  def change
  	add_reference :local_contacts, :country, index: true 
  	add_reference :scientific_contacts, :country, index: true 
  end
end
