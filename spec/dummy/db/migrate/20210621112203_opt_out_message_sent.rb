class OptOutMessageSent < ActiveRecord::Migration[6.0]
  def change
    add_column :twilio_logs, :opt_out_message_sent, :boolean, null: false, default: false
    add_index :twilio_logs, :opt_out_message_sent
    add_index :twilio_logs, :from_number
    add_index :twilio_logs, :to_number
    add_index :twilio_logs, :success
    add_index :twilio_logs, :created_at
  end
end
