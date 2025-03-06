class RenameTwilioLogs < ActiveRecord::Migration[7.0]
  def change
    rename_table :twilio_logs, :contact_logs
    rename_table :twilio_log_attachments, :contact_log_attachments
    rename_column :contact_log_attachments, :twilio_log_id, :contact_log_id
  end
end
