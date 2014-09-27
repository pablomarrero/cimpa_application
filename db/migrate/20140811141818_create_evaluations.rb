class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.date :date_due
      t.references :person, index: true
      t.text :organization
      t.text :standard
      t.text :suitability
      t.text :funding
      t.text :report
      t.text :assessment

      t.timestamps
    end
  end
end
