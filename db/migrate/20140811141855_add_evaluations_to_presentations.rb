class AddEvaluationsToPresentations < ActiveRecord::Migration
  def change
  	add_column :presentations, :evaluation1_id, :integer
  	add_column :presentations, :evaluation2_id, :integer
  end
end
