class AddMessageTypeToSystemMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :system_messages, :message_type, :integer, null: false
  end
end
