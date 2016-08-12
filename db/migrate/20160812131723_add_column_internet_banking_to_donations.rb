class AddColumnInternetBankingToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :internet_banking, :string
  end
end
