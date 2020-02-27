class CreateRadCommonNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :notification_type_id, null: false
      t.boolean :unread, null: false, default: true

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, :notification_type_id

    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :notification_types

    add_column :notification_settings, :email, :boolean, null: false, default: true
    add_column :notification_settings, :feed, :boolean, null: false, default: false
    add_column :notification_settings, :sms, :boolean, null: false, default: false
  end
end
