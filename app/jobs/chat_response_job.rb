class ChatResponseJob < ApplicationJob
  queue_as :default

  def perform(assistant_session_id, message)
    assistant_session = AssistantSession.find(assistant_session_id)
    service = assistant_session.chat_instance
    begin
      _, messages = service.basic_question(message)
      assistant_session.update!(log: messages, status: 'completed', current_message: nil)
    rescue Faraday::BadRequestError => e
      capture_and_log_error(assistant_session, e)
    rescue StandardError => e
      raise e if Rails.env.development?

      capture_and_log_error(assistant_session, e)
    end
  end

  def capture_and_log_error(assistant_session, error)
    raise error if Rails.env.development?

    Sentry.capture_exception(error)
    error_messages = assistant_session.log ||= []
    error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
    assistant_session.update!(log: error_messages, status: :failed, current_message: nil)
  end
end
