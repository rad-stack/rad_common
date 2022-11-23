class TwilioLogChanges < ActiveRecord::Migration[6.1]
  def change
    add_column :twilio_logs, :message_sid, :string
    add_column :twilio_logs, :twilio_status, :integer
  end
end
