class NotificationAuthMode < ActiveRecord::Migration[5.2]
  def change
    add_column :notification_types, :auth_mode, :integer, null: false, default: 0
  end
end
