class AssistantSession < ApplicationRecord
  audited
  strip_attributes

  belongs_to :user
  belongs_to :contextable, polymorphic: true, optional: true
  belongs_to :chat_scope, polymorphic: true, optional: true

  enum status: { processing: 0, completed: 1, failed: 2 }, _prefix: true

  attr_accessor :current_message

  scope :sorted, -> { order(created_at: :desc) }

  delegate :assistant_name, :context_object?, :format_message, to: :chat_instance

  validate :validate_chat_class

  def self.create_or_find_chat(user, chat_class, scope = nil)
    # TODO: maybe rename column chat_type to chat_class?
    AssistantSession.find_or_create_by! user: user,
                                        chat_type: chat_class,
                                        chat_scope: scope
  end

  def chat_type_class
    RadAssistant.retrieve_chat_class(chat_type) || raise("Invalid chat type: #{chat_type}")
  end

  def chat_instance
    @chat_instance ||= chat_type_class.new(self)
  end

  def common_questions
    chat_type_class.common_question_map.keys
  end

  def to_s
    "#{chat_type.humanize.titleize} for #{user}"
  end

  private

    def validate_chat_class
      errors.add(:chat_type, "Invalid chat type #{chat_type}") if RadAssistant.retrieve_chat_class(chat_type).nil?
    end
end
