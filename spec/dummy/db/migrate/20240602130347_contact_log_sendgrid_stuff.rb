class ContactLogSendgridStuff < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_log_recipients, :email_status, :integer
    rename_column :contact_log_recipients, :sms_success, :success
    rename_column :contact_logs, :sms_sent, :sent
    change_column_null :contact_logs, :content, true
    change_column_default :contact_logs, :sent, false
  end
end
