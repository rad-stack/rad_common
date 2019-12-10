class DeviseLockable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :failed_attempts, :integer, null: false, default: 0
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
  end
end
