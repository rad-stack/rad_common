class TwilioLogChanges < ActiveRecord::Migration[6.1]
  def change
    add_column :twilio_logs, :message_sid, :string
    add_column :twilio_logs, :twilio_status, :integer

    rename_column :twilio_logs, :success, :sent

    add_column :twilio_logs, :success, :boolean, null: false, default: false
  end
end
