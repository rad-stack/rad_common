class RenameChatTypeToChatClass < ActiveRecord::Migration[7.2]
  def change
    rename_column :assistant_sessions, :chat_type, :chat_class
  end
end
