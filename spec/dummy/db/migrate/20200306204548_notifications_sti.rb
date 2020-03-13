class NotificationsSti < ActiveRecord::Migration[6.0]
  def change
    rename_column :notification_types, :name, :type
    remove_column :notification_types, :auth_mode
  end
end
