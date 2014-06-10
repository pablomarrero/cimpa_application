class CreateLocalContact < ActiveRecord::Migration
  def change
    create_table :local_contacts do |t|
      t.string :administration_name
      t.string :administration_place
      t.string :administration_email
      t.string :administration_phone

  	  t.attachment :administration_cv

  	  t.references :presentation
      t.timestamps
    end
  end
end
