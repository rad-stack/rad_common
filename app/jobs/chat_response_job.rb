class ChatResponseJob < ApplicationJob
  queue_as :default

  def perform(llm_chat_id, message)
    llm_chat = LLMChat.find(llm_chat_id)
    service = llm_chat.chat_instance
    begin
      _, messages = service.basic_question(message)
      llm_chat.update!(log: messages, status: 'completed', current_message: nil)
    rescue Faraday::BadRequestError => e
      capture_and_log_error(llm_chat, e.response[:body], e)
    rescue StandardError => e
      capture_and_log_error(llm_chat, e.message, e)
    end
  end

  def capture_and_log_error(llm_chat, message, error)
    Sentry.capture_exception(error)
    error_messages = llm_chat.log ||= []
    error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
    error_messages << { role: 'error reporter', content: message }
    llm_chat.update!(log: error_messages, status: :failed, current_message: nil)
  end
end
