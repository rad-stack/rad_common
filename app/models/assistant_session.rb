class AssistantSession < ApplicationRecord
  audited
  strip_attributes

  belongs_to :user
  belongs_to :contextable, polymorphic: true, optional: true
  belongs_to :chat_scope, polymorphic: true, optional: true

  enum :status, { processing: 0, completed: 1, failed: 2 }, prefix: true

  attr_accessor :current_message

  scope :sorted, -> { order(created_at: :desc) }

  delegate :assistant_name, :format_message, :system_prompt, to: :chat_instance

  validate :validate_chat_class

  def self.create_or_find_chat(user, chat_class, scope = nil, chat_parameters: {})
    session = find_or_create_by!(user: user, chat_class: chat_class, chat_scope: scope)
    session.update_chat_parameters!(chat_parameters)
    session
  end

  def update_chat_parameters!(new_parameters)
    return if new_parameters.blank?
    return if chat_parameters == new_parameters.stringify_keys

    update!(chat_parameters: new_parameters, log: purge_tool_calls(log))
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

  private

    # If the chat parameters change, expire existing tool calls in the logs to avoid stale data
    def purge_tool_calls(existing_log)
      return existing_log if existing_log.blank?

      existing_log.map do |item|
        next item unless %w[function_call function_call_output].include?(item['type'])

        item.merge('expires_at' => Time.current.to_s)
      end
    end

    def validate_chat_class
      errors.add(:chat_class, "Invalid chat type #{chat_class}") if RadAssistant.retrieve_chat_class(chat_class).nil?
    end
end
