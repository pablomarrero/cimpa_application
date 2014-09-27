class AddCancelDateToProposal < ActiveRecord::Migration
  def change
  	add_column :presentations, :cancel_date, :date
  end
end
