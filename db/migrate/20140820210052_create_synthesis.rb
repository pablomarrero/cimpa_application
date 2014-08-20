class CreateSynthesis < ActiveRecord::Migration
  def change
    create_table :syntheses do |t|
      t.date :date_due
      t.references :user, index: true
      t.text :summary
      t.text :comment

      t.timestamps
    end
  end
end
