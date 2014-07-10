class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code
      t.string :code_4d
      t.string :name_fr
      t.string :name_en
      t.string :name_short_fr
      t.string :name_short_en
      t.string :region
      t.string :postal_zone
      t.string :dhl_zone

      t.timestamps
    end
  end
end
