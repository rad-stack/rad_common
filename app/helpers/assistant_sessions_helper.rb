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

    ChatPanel.new(
      chat_list_id: assistant_session.chat_list_id,
      record: assistant_session,
      form_url: chat_message_update_path(chatable_type: assistant_session.class.name, id: assistant_session.id),
      input_name: assistant_session.input_name,
      input_id: assistant_session.input_id,
      input_classes: 'form-control ays-ignore',
      placeholder: 'Ask a question...',
      messages: messages,
      form_data: { controller: 'llm-chat-form', 'llm-chat-form-target': 'form' },
      input_data: { 'llm-chat-form-target': 'currentMessage' },
      turbo_frame: 'chat-form',
      before_input_partial: 'assistant_sessions/common_questions_dropdown',
      before_input_locals: { assistant_session: assistant_session },
      after_submit_partial: 'assistant_sessions/reset_chat_button',
      after_submit_locals: {},
      offcanvas_id: 'basic-question-modal',
      offcanvas_title: 'Ask Question?'
    )
  end

  private

    def assistant_session_logs(assistant_session)
      return [] if assistant_session.log.blank?

      raw_data = assistant_session.log
      raw_data.select { |message| VISIBLE_ROLES.include?(message['role']) && message['content'].present? }
    end

    def assistant_session_log_list(assistant_session)
      assistant_session_logs(assistant_session).map { |log| assistant_session.chat_message_from_log(log, current_user) }
    end
end
