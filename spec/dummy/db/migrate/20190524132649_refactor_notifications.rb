class RefactorNotifications < ActiveRecord::Migration[5.2]
  def change
    production = Rails.env.production?

    create_table :notification_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :notification_types, :name, unique: true

    add_column :notification_security_roles, :notification_type_id, :integer

    change_column :notification_security_roles, :notification_type_id, :integer, null: false
    remove_column :notification_security_roles, :notification_type
    add_index :notification_security_roles, %i[notification_type_id security_role_id], unique: true, name: 'unique_notification_roles'
    add_foreign_key :notification_security_roles, :notification_types

    add_column :notification_settings, :notification_type_id, :integer

    if production
      execute 'UPDATE notification_settings SET notification_type_id = (SELECT id FROM notification_types WHERE name = notification_settings.notification_type)'
    end

    change_column :notification_settings, :notification_type_id, :integer, null: false
    remove_column :notification_settings, :notification_type
    add_index :notification_settings, %i[notification_type_id user_id], unique: true
    add_foreign_key :notification_settings, :notification_types
  end
end
