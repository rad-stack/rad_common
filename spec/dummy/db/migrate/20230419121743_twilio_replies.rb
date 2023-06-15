class TwilioReplies < ActiveRecord::Migration[6.1]
  def change
    add_column :twilio_logs, :log_type, :integer

    if TwilioLog.exists?
      execute 'UPDATE twilio_logs SET log_type = 0;'
    end

    change_column_null :twilio_logs, :log_type, false
    change_column_null :twilio_logs, :from_user_id, true
  end
end
