module DirectMessagesHelper
  def direct_message_chat_panel(direct_message)
    messages = direct_message_log_list(direct_message)

    ChatPanel.new(
      chat_list_id: "direct-message-#{direct_message.id}-chat",
      record: direct_message,
      input_name: 'direct_message[current_message]',
      input_id: 'direct_message_current_message',
      messages: messages,
      form_data: { controller: 'chat-form dm-typing',
                   'dm-typing-url-value': typing_direct_message_path(direct_message) },
      input_data: { 'dm-typing-target': 'input', action: 'input->dm-typing#onInput blur->dm-typing#onBlur' }
    )
  end

  private

    def direct_message_log_list(direct_message)
      return [] if direct_message.log.blank?

      direct_message.log.map { |log| direct_message_log_entry(log.symbolize_keys) }
    end

    def direct_message_log_entry(log)
      is_current_user = log[:user_id].to_s == current_user.id.to_s
      direction = is_current_user ? 'left' : 'right'
      user_name = is_current_user ? current_user.to_s : User.find(log[:user_id]).to_s

      ChatMessage.new(direction: direction, user_name: user_name,
                      message: log[:content], chat_date: log[:chat_date],
                      user: is_current_user ? current_user : nil)
    end
end
