class AddDescriptionToPresentation < ActiveRecord::Migration
  def change
  	add_column :presentations, :comment, :text
  end
end
