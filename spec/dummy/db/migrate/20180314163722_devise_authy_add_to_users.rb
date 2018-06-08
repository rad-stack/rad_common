class DeviseAuthyAddToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authy_id, :string, references: nil
    add_column :users, :last_sign_in_with_authy, :datetime
    add_column :users, :authy_enabled, :boolean, null: false, default: false

    add_index :users, :authy_id
  end
end
