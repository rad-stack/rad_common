class TwilioReplies < ActiveRecord::Migration[6.1]
  def change
    add_column :twilio_logs, :log_type, :integer
    change_column_null :twilio_logs, :log_type, false
    change_column_null :twilio_logs, :from_user_id, true
  end
end
