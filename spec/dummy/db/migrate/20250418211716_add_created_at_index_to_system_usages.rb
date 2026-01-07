class AddCreatedAtIndexToSystemUsages < ActiveRecord::Migration[7.2]
  def change
    add_index :notifications, :created_at
    add_index :users, :created_at
    add_index :contact_log_recipients, :created_at
  end
end
