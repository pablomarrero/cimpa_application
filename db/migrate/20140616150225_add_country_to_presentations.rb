class AddCountryToPresentations < ActiveRecord::Migration
  def change
  	add_reference :presentations, :country, index: true 
  end
end
