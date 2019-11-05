class AddMessageTypeToSystemMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :system_messages, :message_type, :integer

    SystemMessage.update_all(message_type: 'email') if Rails.env.production?

    change_column :system_messages, :message_type, :integer, null: false
  end
end
