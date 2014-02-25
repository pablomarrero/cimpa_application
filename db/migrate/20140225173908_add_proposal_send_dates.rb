class AddProposalSendDates < ActiveRecord::Migration
  def change
  	add_column :presentations, :pre_proposal_date, :datetime 
  	add_column :presentations, :final_proposal_date, :datetime 
  end
end
