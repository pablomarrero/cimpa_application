class AddProposalState < ActiveRecord::Migration
  def change
  	add_column :presentations, :proposal_state, :string
  end
end
