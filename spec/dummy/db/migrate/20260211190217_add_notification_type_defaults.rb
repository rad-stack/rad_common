class AddNotificationTypeDefaults < ActiveRecord::Migration[7.2]
  def change
    add_column :notification_types, :default_email, :boolean, null: false, default: false
    add_column :notification_types, :default_feed, :boolean, null: false, default: false
    add_column :notification_types, :default_sms, :boolean, null: false, default: false
  end
end
