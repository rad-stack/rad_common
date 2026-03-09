class AssistantSession < ApplicationRecord
  include Chatable

  audited
  strip_attributes

  belongs_to :user
  belongs_to :contextable, polymorphic: true, optional: true
  belongs_to :chat_scope, polymorphic: true, optional: true

  enum :status, { processing: 0, completed: 1, failed: 2 }, prefix: true

  scope :sorted, -> { order(created_at: :desc) }

  delegate :assistant_name, :context_object?, :format_message, to: :chat_instance

  validate :validate_chat_class

  def self.create_or_find_chat(user, chat_class, scope = nil)
    AssistantSession.find_or_create_by! user: user,
                                        chat_class: chat_class,
                                        chat_scope: scope
  end

  def chat_list_id
    "chat_assistant_session_#{id}"
  end

  def chat_type_class
    RadAssistant.retrieve_chat_class(chat_class) || raise("Invalid chat type: #{chat_class}")
  end

  def chat_instance
    @chat_instance ||= chat_type_class.new(self)
  end

  def common_questions
    chat_type_class.common_question_map.keys
  end

  def create_message(message:, user:)
    self.status = 'processing'
    self.log ||= []
    save!

    ChatResponseJob.perform_later(id, message)
    LLM::PromptBuilder.build_user_message(message)
  end

  def chat_message_from_log(log_entry, current_user)
    log_entry = log_entry.symbolize_keys
    direction = log_entry[:role] == 'user' ? 'left' : 'right'
    user_name = log_entry[:role] == 'user' ? current_user.to_s : assistant_name
    message = format_message(log_entry[:content])

    ChatMessage.new(direction: direction, user_name: user_name, message: message,
                    chat_date: log_entry[:chat_date], user: direction == 'left' ? current_user : nil)
  end

  def chat_permitted_params
    %i[current_message contextable_id contextable_type]
  end

  def prepare_for_chat_update(params, current_user)
    if params['reset_chat'].present?
      update!(status: 'processing', current_message: nil, log: [])
      return { reset: true }
    end

    if context_object? && contextable_id.blank?
      log_entry = LLM::PromptBuilder.build_assistant_message('User is missing, please try again')
      self.log ||= []
      self.log << log_entry
      save
      return { chat_msg: chat_message_from_log(log_entry, current_user) }
    end

    nil
  end

  def handle_blank_chat_message(current_user)
    log_entry = LLM::PromptBuilder.build_assistant_message('Message is missing, please try again')
    self.log ||= []
    self.log << log_entry
    save
    chat_message_from_log(log_entry, current_user)
  end

  def after_chat_message_created(_current_user)
    self.response_id = "#{id}-#{Time.current.to_i}"
  end

  def after_update_partial
    'assistant_sessions/chat_polling_frame'
  end

  def after_update_locals
    { assistant_session: self }
  end

  def welcome_message
    ChatMessage.new(direction: 'right', user_name: assistant_name,
                    message: 'Hello, what can I help you with?',
                    chat_date: I18n.l(Time.current, format: :long))
  end

  attr_accessor :response_id

  def to_s
    "#{chat_class.humanize.titleize} for #{user}"
  end

  private

    def validate_chat_class
      errors.add(:chat_class, "Invalid chat type #{chat_class}") if RadAssistant.retrieve_chat_class(chat_class).nil?
    end
end
