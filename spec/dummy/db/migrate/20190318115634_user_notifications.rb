class UserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :notifications, :name, unique: true

    create_table :user_notifications do |t|
      t.integer :user_id, null: false
      t.integer :notification_id, null: false
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end

    add_index :user_notifications, %i[user_id notification_id], unique: true

    add_foreign_key :user_notifications, :users
    add_foreign_key :user_notifications, :notifications
  end
end
