class RenameTwilioLogs < ActiveRecord::Migration[7.0]
  def change
    rename_table :twilio_logs, :contact_logs
    rename_table :twilio_log_attachments, :contact_log_attachments
  end
end
