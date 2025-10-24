class FixChatTypes < ActiveRecord::Migration[7.2]
  def change
    AssistantSession.where(chat_type: 'basic')
                    .update_all(chat_type: 'LLM::ChatTypes::SystemChat')
  end
end
