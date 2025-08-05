class AddOmniauthToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index :users, [:provider, :uid], unique: true
  end
end
