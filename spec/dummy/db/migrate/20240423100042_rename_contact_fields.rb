class RenameContactFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :contact_logs, :media_url, :sms_media_url
    rename_column :contact_logs, :sent, :sms_sent
    rename_column :contact_logs, :opt_out_message_sent, :sms_opt_out_message_sent
    rename_column :contact_logs, :message_sid, :sms_message_id
    rename_column :contact_logs, :log_type, :sms_log_type

    rename_column :contact_log_recipients, :service_status, :sms_status
    rename_column :contact_log_recipients, :success, :sms_success

    remove_column :contact_logs, :reply_to

    change_column_null :contact_logs, :sms_log_type, true
  end
end
