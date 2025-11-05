class RenameLLMChatsToAssistantSessions < ActiveRecord::Migration[7.2]
  def change
    rename_table :llm_chats, :assistant_sessions
    rename_index :llm_chats, 'index_llm_chats_on_chat_scope', 'index_assistant_sessions_on_chat_scope'
    rename_index :llm_chats, 'index_llm_chats_on_contextable', 'index_assistant_sessions_on_contextable'
    return if Audited::Audit.none?

    execute "UPDATE audits SET auditable_type = 'AssistantSession' WHERE auditable_type = 'LLMChat';"
  end
end
