class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :person, index: true
      t.references :friend, index: true

      t.timestamps
    end
  end
end
