class AddChatParametersToAssistantSessions < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_sessions, :chat_parameters, :jsonb, default: {}
  end
end
