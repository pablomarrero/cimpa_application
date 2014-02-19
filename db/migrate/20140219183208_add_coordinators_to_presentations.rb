class AddCoordinatorsToPresentations < ActiveRecord::Migration
  def change
  	add_column :presentations, :administration_name, :string
  	add_column :presentations, :administration_place, :string
  	add_column :presentations, :administration_email, :string
  	add_column :presentations, :administration_phone, :string
  	add_attachment :presentations, :administration_cv
  	add_column :presentations, :scientific_name, :string
  	add_column :presentations, :scientific_place, :string
  	add_column :presentations, :scientific_email, :string
  	add_column :presentations, :scientific_phone, :string
  	add_attachment :presentations, :scientific_cv
  end
end
