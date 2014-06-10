class CreateScientificContact < ActiveRecord::Migration
  def change
    create_table :scientific_contacts do |t|

  	  t.string :scientific_name
  	  t.string :scientific_place
  	  t.string :scientific_email
  	  t.string :scientific_phone, :string
  	
  	  t.attachment :scientific_cv

  	  t.references :presentation
      t.timestamps    
    end
  end
end
