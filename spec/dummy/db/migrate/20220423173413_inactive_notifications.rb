class InactiveNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notification_types, :active, :boolean, null: false, default: true
  end
end
