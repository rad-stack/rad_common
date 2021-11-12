class FixNotificationDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column :notification_settings, :email, :boolean, null: false, default: false
  end
end
