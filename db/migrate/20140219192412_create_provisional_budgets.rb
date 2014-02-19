class CreateProvisionalBudgets < ActiveRecord::Migration
  def change
    create_table :provisional_budgets do |t|
      t.references :presentation, index: true
      t.string :description
      t.decimal :amount
      t.string :provisional_type

      t.timestamps
    end
  end
end
