class CreateAnticipatedFundings < ActiveRecord::Migration
  def change
    create_table :anticipated_fundings do |t|
      t.references :presentation, index: true
      t.string :description
      t.decimal :amount
      t.string :anticipated_type

      t.timestamps
    end
  end
end
