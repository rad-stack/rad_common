class ActiveRecordDoctorIssues < ActiveRecord::Migration[7.0]
  def change
    change_column :notification_settings, :notification_type_id, :bigint, null: false
    change_column :notifications, :notification_type_id, :bigint, null: false
    change_column :users, :id, :bigint, null: false
    change_column :companies, :id, :bigint, null: false
    change_column :user_statuses, :id, :bigint, null: false
    change_column :audits, :id, :bigint, null: false
    change_column :security_roles, :id, :bigint, null: false
    change_column :user_security_roles, :id, :bigint, null: false
    change_column :users, :invited_by_id, :bigint
    change_column :users, :user_status_id, :bigint, null: false
    change_column :notification_settings, :user_id, :bigint, null: false
    change_column :notification_security_roles, :security_role_id, :bigint, null: false
    change_column :notification_security_roles, :notification_type_id, :bigint, null: false
    change_column :notifications, :user_id, :bigint, null: false
    change_column :system_messages, :security_role_id, :bigint
    change_column :system_messages, :user_id, :bigint, null: false
    change_column :user_clients, :client_id, :bigint, null: false
    change_column :user_clients, :user_id, :bigint, null: false
    change_column :twilio_logs, :to_user_id, :bigint
    change_column :twilio_logs, :from_user_id, :bigint
    change_column :audits, :user_id, :bigint
    change_column :user_security_roles, :user_id, :bigint, null: false
    change_column :user_security_roles, :security_role_id, :bigint, null: false

    change_column :companies, :name, :string, limit: nil, null: false
    change_column :companies, :phone_number, :string, limit: nil, null: false
    change_column :companies, :website, :string, limit: nil, null: false
    change_column :companies, :email, :string, limit: nil, null: false
    change_column :companies, :address_1, :string, limit: nil, null: false
    change_column :companies, :address_2, :string, limit: nil
    change_column :companies, :city, :string, limit: nil, null: false
    change_column :companies, :state, :string, limit: nil, null: false
    change_column :companies, :zipcode, :string, limit: nil, null: false

    change_column :users, :email, :string, limit: nil, default: "", null: false
    change_column :users, :encrypted_password, :string, limit: nil, default: "", null: false
    change_column :users, :reset_password_token, :string, limit: nil
    change_column :users, :current_sign_in_ip, :string, limit: nil
    change_column :users, :last_sign_in_ip, :string, limit: nil
    change_column :users, :confirmation_token, :string, limit: nil
    change_column :users, :unconfirmed_email, :string, limit: nil
    change_column :users, :first_name, :string, limit: nil, null: false
    change_column :users, :last_name, :string, limit: nil, null: false
    change_column :users, :mobile_phone, :string, limit: nil
    change_column :users, :timezone, :string, limit: nil, null: false
    change_column :users, :global_search_default, :string, limit: nil
  end
end
