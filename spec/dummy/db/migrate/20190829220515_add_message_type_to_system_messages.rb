class AddMessageTypeToSystemMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :system_messages, :message_type, :integer, null: false

    add_column :companies, :twilio_phone_numbers, :text, array: true, default: []
  end
end
