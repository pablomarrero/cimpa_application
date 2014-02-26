class AddCurrenciesToPresentations < ActiveRecord::Migration
  def change
  	add_reference :provisional_budgets, :currency, index: true 
  	add_reference :anticipated_fundings, :currency, index: true 
  end
end
