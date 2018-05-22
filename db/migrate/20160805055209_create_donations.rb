class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :payer_id
      t.integer :user_id
      t.integer :initiative_id
      t.integer :amount
      t.string :description
      t.string :currency
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
