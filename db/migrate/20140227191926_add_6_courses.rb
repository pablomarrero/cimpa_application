class Add6Courses < ActiveRecord::Migration
  def change
  	rename_column :presentations, :courses, :course1
  	add_column :presentations, :course2, :text
  	add_column :presentations, :course3, :text
  	add_column :presentations, :course4, :text
  	add_column :presentations, :course5, :text
  	add_column :presentations, :course6, :text
  	
  end
end
