class AddModificationRequestDatesToPresentations < ActiveRecord::Migration
  def change
  	add_column :presentations, :modification1_req_date, :date 
  	add_column :presentations, :modification2_req_date, :date
  end
end
