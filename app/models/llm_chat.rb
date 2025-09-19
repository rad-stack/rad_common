class LLMChat < ApplicationRecord
  audited
  strip_attributes

  CHAT_TYPES = { basic: LLM::ChatTypes::AttorneyChat }.freeze

  belongs_to :user
  belongs_to :contextable, polymorphic: true, optional: true
  belongs_to :chat_scope, polymorphic: true, optional: true

  enum status: { processing: 0, completed: 1, failed: 2 }

  attr_accessor :current_message

  delegate :assistant_name, to: :chat_instance

  def self.basic_chat(user, scope = nil)
    LLMChat.find_or_create_by!(user: user, chat_type: 'basic', chat_scope: scope)
  end

  def chat_type_class
    CHAT_TYPES[chat_type.to_sym] || raise('Invalid chat type')
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
end
