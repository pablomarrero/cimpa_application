class AddModificationDatesToPresentations < ActiveRecord::Migration
  def change
  	add_column :presentations, :modification1_date, :date 
  	add_column :presentations, :modification2_date, :date
  end
end
