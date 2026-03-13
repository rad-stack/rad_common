class DirectMessage < ApplicationRecord
  include Chattable

  audited
  strip_attributes

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  scope :sorted, -> { order(updated_at: :desc) }
  scope :for_user, ->(user) { where(sender: user).or(where(recipient: user)) }

  validates :sender_id, uniqueness: { scope: :recipient_id, message: 'conversation already exists' }
  validate :sender_is_not_recipient

  def self.find_or_create_conversation(user_a, user_b)
    find_by(sender: user_a, recipient: user_b) ||
      find_by(sender: user_b, recipient: user_a) ||
      create!(sender: user_a, recipient: user_b)
  end

  def other_user(user)
    user == sender ? recipient : sender
  end

  def to_s
    "Conversation between #{sender} and #{recipient}"
  end

  def participant?(user)
    sender_id == user.id || recipient_id == user.id
  end

  # Chattable interface implementation

  def handle_chat_message(message, user)
    self.log ||= []

    if message.nil?
      self.log << { 'role' => 'assistant', 'content' => 'Message is missing, please try again',
                    'chat_date' => ApplicationController.helpers.format_datetime(DateTime.current) }
      save!
    else
      self.log << { 'role' => 'user', 'content' => message, 'user_id' => user.id,
                    'user_name' => user.to_s,
                    'chat_date' => ApplicationController.helpers.format_datetime(DateTime.current) }
      save!
      broadcast_new_message(message, user)
    end
  end

  def chat_messages_log
    log || []
  end

  def chat_responder_name
    'Direct Message'
  end

  def chat_processing?
    false
  end

  def reset_chat!
    update!(log: [])
  end

  private

    def sender_is_not_recipient
      errors.add(:recipient, "can't be the same as sender") if sender_id == recipient_id
    end

    def broadcast_new_message(message, user)
      chat_date = ApplicationController.helpers.format_datetime(DateTime.current)
      target = ActionView::RecordIdentifier.dom_id(self, 'chat')
      receiving_user = other_user(user)

      Turbo::StreamsChannel.broadcast_append_to(
        [self, receiving_user],
        target: target,
        partial: 'rad_chat/chat_message_right',
        locals: { message: message, user_name: user.to_s, chat_date: chat_date, user: user }
      )
      Turbo::StreamsChannel.broadcast_action_to(
        [self, receiving_user], action: :scroll_bottom, target: 'scroll-container'
      )
    end
end
