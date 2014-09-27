class AddSynthesisToPresentations < ActiveRecord::Migration
  def change
  	add_column :presentations, :synthesis1_id, :integer, index: true
  	add_column :presentations, :synthesis2_id, :integer, index: true
  end
end
