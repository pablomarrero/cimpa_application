class AddAcronymToProposals < ActiveRecord::Migration
  def change
  	add_column :presentations, :acronym, :string
  end
end
