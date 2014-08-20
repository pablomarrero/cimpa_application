class AddEvaluatorsToPresentation < ActiveRecord::Migration
  def change
  	add_column :presentations, :evaluator1_id, :integer, index: true
  	add_column :presentations, :evaluator2_id, :integer, index: true
  end
end
