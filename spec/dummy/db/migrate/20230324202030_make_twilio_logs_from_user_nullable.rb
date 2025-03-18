class MakeTwilioLogsFromUserNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :twilio_logs, :from_user_id, true
  end
end
