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

    create_table :notification_security_roles do |t|
      t.string :notification_type, null: false
      t.integer :security_role_id, null: false

      t.timestamps
    end

    add_index :notification_security_roles, %i[security_role_id notification_type], unique: true, name: 'unique_notification_roles'
    add_foreign_key :notification_security_roles, :security_roles
  end
end
