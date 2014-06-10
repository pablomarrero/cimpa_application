class RemovePresentationFields < ActiveRecord::Migration
  def change
  	remove_column :presentations, :scientific_name, :string
  	remove_column :presentations, :scientific_place, :string
  	remove_column :presentations, :scientific_email, :string
  	remove_column :presentations, :scientific_phone, :string
  	remove_attachment :presentations, :scientific_cv

  	remove_column :presentations, :administration_name, :string
  	remove_column :presentations, :administration_place, :string
  	remove_column :presentations, :administration_email, :string
  	remove_column :presentations, :administration_phone, :string
  	remove_attachment :presentations, :administration_cv
  end
end
