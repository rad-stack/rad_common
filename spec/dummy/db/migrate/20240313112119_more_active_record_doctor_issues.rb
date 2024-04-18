class MoreActiveRecordDoctorIssues < ActiveRecord::Migration[7.0]
  def change
    add_index :notification_settings, :user_id
    add_index :notification_settings, :notification_type_id
    add_index :user_clients, :user_id
    add_index :user_clients, :client_id
    add_index :notification_security_roles, :security_role_id
    add_index :notification_security_roles, :notification_type_id
  end
end
