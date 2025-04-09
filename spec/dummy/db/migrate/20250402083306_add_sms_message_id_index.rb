class AddSMSMessageIdIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :contact_logs, :sms_message_id
  end
end
