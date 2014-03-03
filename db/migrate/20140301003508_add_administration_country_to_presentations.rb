class AddAdministrationCountryToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :administration_country, :string
  end
end
