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

  def assistant_session_logs(assistant_session)
    return [] if assistant_session.log.blank?

    raw_data = assistant_session.log
    raw_data.select { |message| VISIBLE_ROLES.include?(message['role']) && message['content'].present? }
  end

  def assistant_session_log_list(assistant_session)
    assistant_session_logs(assistant_session).map { |log| assistant_session_log_data(assistant_session, log) }
  end

  def assistant_session_log_data(assistant_session, log)
    log.symbolize_keys!
    user_name = log[:role] == 'user' ? current_user.to_s : assistant_session.assistant_name
    template = "assistant_sessions/chat_message_#{log[:role] == 'user' ? 'right' : 'left'}"
    message = assistant_session.format_message(log[:content])
    { direction: 'left', user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: current_user }
  end

  def assistant_session_format_message(message)
    remove_context_data(message)
  end

  private

    def remove_context_data(text)
      text.gsub(/CONTEXT_DATA_FOLLOWS.*\z/m, '')
    end
end
