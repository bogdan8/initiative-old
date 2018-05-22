class AddColumnsNamePostPhoneAvatarToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :post, :string
    add_column :users, :phone, :string
    add_column :users, :avatar, :string
  end
end
