class AddColumnCollectedAmountToInitiativesTable < ActiveRecord::Migration
  def change
    add_column :initiatives, :collected_amount, :integer, default: 0, null: false
  end
end
