class AddTentativeScheduleFile < ActiveRecord::Migration
  def change
  	add_attachment :presentations, :tentative_schedule_file
  end
end
