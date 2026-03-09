class ChatResponseJob < ApplicationJob
  queue_as :default

  def perform(assistant_session_id, message)
    assistant_session = AssistantSession.find(assistant_session_id)
    service = assistant_session.chat_instance
    begin
      _, messages = service.basic_question(message)
      assistant_session.update!(log: messages, status: 'completed', current_message: nil)
      broadcast_response(assistant_session)
    rescue Faraday::BadRequestError => e
      capture_and_log_error(assistant_session, e)
    rescue StandardError => e
      raise e if Rails.env.development?

      capture_and_log_error(assistant_session, e)
    end
  end

  private

    def capture_and_log_error(assistant_session, error)
      raise error if Rails.env.development?

      Sentry.capture_exception(error)
      error_messages = assistant_session.log ||= []
      error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
      assistant_session.update!(log: error_messages, status: :failed, current_message: nil)
      broadcast_response(assistant_session)
    end

    def broadcast_response(assistant_session)
      logs = assistant_session.log || []
      latest = logs.reverse.find { |msg| msg['role'] == 'assistant' }
      return unless latest

      latest.symbolize_keys!
      message = assistant_session.format_message(latest[:content])

      Turbo::StreamsChannel.broadcast_replace_to(
        assistant_session,
        target: 'loading-message',
        partial: 'assistant_sessions/chat_message_right',
        locals: { message: message, user_name: assistant_session.assistant_name, chat_date: latest[:chat_date] }
      )
      Turbo::StreamsChannel.broadcast_action_to(assistant_session, action: :scroll_bottom, target: 'scroll-container')
      Turbo::StreamsChannel.broadcast_action_to(assistant_session, action: :enable_element,
                                                                   target: 'chat-submit-btn')
    end
end
