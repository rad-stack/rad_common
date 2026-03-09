module Chattable
  extend ActiveSupport::Concern

  included do
    attr_accessor :current_message
  end

  # Required: Handle an incoming chat message from a user.
  # Should create associated records and return the updated chat messages log.
  # Must call broadcast_chat_response when the response is ready.
  def handle_chat_message(message, user)
    raise NotImplementedError, "#{self.class} must implement #handle_chat_message"
  end

  # Required: Return an array of chat log entries.
  # Each entry should be a hash with 'role' (user/assistant) and 'content' keys.
  def chat_messages_log
    raise NotImplementedError, "#{self.class} must implement #chat_messages_log"
  end

  # Required: Return the display name for the responder (e.g. "Assistant", "Support Agent").
  def chat_responder_name
    raise NotImplementedError, "#{self.class} must implement #chat_responder_name"
  end

  # Required: Return true if the chat is currently processing a response.
  def chat_processing?
    raise NotImplementedError, "#{self.class} must implement #chat_processing?"
  end

  # Required: Reset the chat to its initial state.
  def reset_chat!
    raise NotImplementedError, "#{self.class} must implement #reset_chat!"
  end

  # Optional: Format a message before display. Override to customize.
  def format_chat_message(text)
    text
  end

  # Optional: Return an array of common question strings. Override to provide preset questions.
  def chat_common_questions
    []
  end

  # Optional: Return true if the chat has a context object picker. Override to enable.
  def chat_context_object?
    false
  end

  # Optional: Return the initial greeting message. Override to customize.
  def chat_initial_greeting
    'Hello, what can I help you with?'
  end

  # Broadcasts the chat response via Turbo Streams after processing.
  def broadcast_chat_response
    logs = chat_messages_log || []
    latest = logs.reverse.find { |msg| msg['role'] == 'assistant' }
    return unless latest

    latest.symbolize_keys!
    message = format_chat_message(latest[:content])

    Turbo::StreamsChannel.broadcast_replace_to(
      self,
      target: 'loading-message',
      partial: 'rad_chat/chat_message_right',
      locals: { message: message, user_name: chat_responder_name, chat_date: latest[:chat_date] }
    )
    Turbo::StreamsChannel.broadcast_action_to(self, action: :scroll_bottom, target: 'scroll-container')
    Turbo::StreamsChannel.broadcast_action_to(self, action: :enable_element, target: 'chat-submit-btn')
  end
end
