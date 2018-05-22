class AddColumnAasmStateToInitiativesTable < ActiveRecord::Migration
  def change
    add_column :initiatives, :aasm_state, :string
  end
end
