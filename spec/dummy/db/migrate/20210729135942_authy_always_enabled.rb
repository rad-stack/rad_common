class AuthyAlwaysEnabled < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :authy_enabled, :boolean, null: false, default: true
  end
end
