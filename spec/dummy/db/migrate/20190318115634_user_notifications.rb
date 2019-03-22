class UserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_settings do |t|
      t.integer :user_id, null: false
      t.string :notification_type, null: false
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end

    add_index :notification_settings, %i[user_id notification_type], unique: true

    add_foreign_key :notification_settings, :users
  end
end
