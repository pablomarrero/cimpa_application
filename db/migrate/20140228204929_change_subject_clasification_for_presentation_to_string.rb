class ChangeSubjectClasificationForPresentationToString < ActiveRecord::Migration
  def up
    change_column :presentations, :subject_clasification, :string
  end

  def down
    change_column :presentations, :subject_clasification, :integer
  end
end
