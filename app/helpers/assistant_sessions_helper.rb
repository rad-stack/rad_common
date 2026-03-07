module AssistantSessionsHelper
  VISIBLE_ROLES = %w[user assistant].freeze

  def ask_basic_question_btn
    return unless policy(AssistantSession).new?

    chat_open_btn('basic-question-modal', label: 'Ask Assistant?')
  end

  def logs_for_session(assistant_session)
    return [] if assistant_session.log.nil?

    assistant_session.log
  end

  def assistant_session_chat_panel(assistant_session)
    messages = assistant_session_log_list(assistant_session)

    if messages.blank?
      messages = [ChatMessage.new(direction: 'right', user_name: assistant_session.assistant_name,
                                  message: 'Hello, what can I help you with?',
                                  chat_date: format_datetime(DateTime.now))]
    end

    ChatPanel.new(chat_list_id: dom_id(assistant_session, 'chat'), messages: messages)
  end

  def assistant_session_log_data(assistant_session, log)
    log.symbolize_keys!
    direction = log[:role] == 'user' ? 'left' : 'right'
    user_name = log[:role] == 'user' ? current_user.to_s : assistant_session.assistant_name
    message = assistant_session.format_message(log[:content])

    ChatMessage.new(direction: direction, user_name: user_name, message: message,
                    chat_date: log[:chat_date], user: direction == 'left' ? current_user : nil)
  end

  private

    def assistant_session_logs(assistant_session)
      return [] if assistant_session.log.blank?

      raw_data = assistant_session.log
      raw_data.select { |message| VISIBLE_ROLES.include?(message['role']) && message['content'].present? }
    end

    def assistant_session_log_list(assistant_session)
      assistant_session_logs(assistant_session).map { |log| assistant_session_log_data(assistant_session, log) }
    end
end
