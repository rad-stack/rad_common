class AssistantSession < ApplicationRecord
  include Chattable

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

  def chat_type_class
    RadAssistant.retrieve_chat_class(chat_class) || raise("Invalid chat type: #{chat_class}")
  end

  def chat_instance
    @chat_instance ||= chat_type_class.new(self)
  end

  def common_questions
    chat_type_class.common_question_map.keys
  end

  def to_s
    "#{chat_class.humanize.titleize} for #{user}"
  end

  # Chattable interface implementation

  def handle_chat_message(message, _user)
    if message.nil?
      self.log ||= []
      self.log << LLM::PromptBuilder.build_assistant_message('Message is missing, please try again')
      save
    else
      self.status = 'processing'
      self.log ||= []
      return unless save!

      ChatResponseJob.perform_later(id, message)
    end
  end

  def chat_messages_log
    log || []
  end

  def chat_responder_name
    assistant_name
  end

  def chat_processing?
    status_processing?
  end

  def reset_chat!
    update!(status: 'processing', current_message: nil, log: [])
  end

  def format_chat_message(text)
    format_message(text)
  end

  def chat_common_questions
    common_questions
  end

  def chat_context_object?
    context_object?
  end

  private

    def validate_chat_class
      errors.add(:chat_class, "Invalid chat type #{chat_class}") if RadAssistant.retrieve_chat_class(chat_class).nil?
    end
end
