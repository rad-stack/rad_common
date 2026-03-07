module DirectMessagesHelper
  def direct_message_chat_panel(direct_message)
    messages = direct_message_log_list(direct_message)

    ChatPanel.new(
      chat_list_id: direct_message.chat_list_id,
      record: direct_message,
      input_name: direct_message.input_name,
      input_id: direct_message.input_id,
      messages: messages,
      form_data: { controller: 'chat-form dm-typing',
                   'dm-typing-url-value': typing_direct_message_path(direct_message) },
      input_data: { 'dm-typing-target': 'input', action: 'input->dm-typing#onInput blur->dm-typing#onBlur' }
    )
  end

  private

    def direct_message_log_list(direct_message)
      return [] if direct_message.log.blank?

      direct_message.log.map { |log| direct_message.chat_message_from_log(log, current_user) }
    end
end
