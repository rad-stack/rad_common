class ChatResponseJob < ApplicationJob
  queue_as :default

  def perform(llm_chat_id, message)
    llm_chat = LLMChat.find(llm_chat_id)
    service = llm_chat.chat_instance
    begin
      _, messages = service.basic_question(message)
      llm_chat.update!(log: messages, status: 'completed', current_message: nil)
    rescue Faraday::BadRequestError => e
      capture_and_log_error(llm_chat, e)
    rescue StandardError => e
      raise e if Rails.env.development?

      capture_and_log_error(llm_chat, e)
    end
  end

  def capture_and_log_error(llm_chat, error)
    raise error if Rails.env.development?

    Sentry.capture_exception(error)
    error_messages = llm_chat.log ||= []
    error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
    llm_chat.update!(log: error_messages, status: :failed, current_message: nil)
  end
end
