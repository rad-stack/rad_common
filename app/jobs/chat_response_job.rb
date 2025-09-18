class ChatResponseJob < ApplicationJob
  queue_as :default

  def perform(llm_chat_id, message)
    llm_chat = LLMChat.find(llm_chat_id)
    chat_class = llm_chat.chat_type_class
    service = chat_class.new(llm_chat)

    begin
      _, messages = service.basic_question(message)
      llm_chat.update!(log: messages, status: 'completed', current_message: nil)
    rescue Faraday::BadRequestError => e
      Sentry.capture_exception(e) if Rails.env.production?
      error_messages = llm_chat.log ||= []
      error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
      error_messages << { role: 'error reporter', content: e.response.body }
      llm_chat.update!(log: error_messages, status: :failed, current_message: nil)
    rescue StandardError => e
      Sentry.capture_exception(e) if Rails.env.production?
      error_messages = llm_chat.log ||= []
      error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
      llm_chat.update!(log: error_messages, status: :failed, current_message: nil)
    end
  end
end
