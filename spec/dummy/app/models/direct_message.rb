class DirectMessage < ApplicationRecord
  include Chatable

  audited

  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  scope :sorted, -> { order(updated_at: :desc) }

  validates :from_user, presence: true
  validates :to_user, presence: true

  def self.find_or_create_conversation(user_a, user_b)
    find_by(from_user: user_a, to_user: user_b) ||
      find_by(from_user: user_b, to_user: user_a) ||
      create!(from_user: user_a, to_user: user_b)
  end

  def chat_list_id
    "direct-message-#{id}-chat"
  end

  def create_message(message:, user:)
    self.log ||= []
    log_entry = { role: 'user', user_id: user.id, content: message, chat_date: I18n.l(Time.current, format: :long) }
    self.log << log_entry
    save!
    log_entry
  end

  def chat_message_from_log(log_entry, current_user)
    log_entry = log_entry.symbolize_keys
    is_current_user = log_entry[:user_id].to_s == current_user.id.to_s
    direction = is_current_user ? 'left' : 'right'
    user_name = is_current_user ? current_user.to_s : User.find(log_entry[:user_id]).to_s

    ChatMessage.new(direction: direction, user_name: user_name,
                    message: log_entry[:content], chat_date: log_entry[:chat_date],
                    user: is_current_user ? current_user : nil)
  end

  def after_chat_message_created(current_user)
    broadcast_message_to_other_user(current_user)
  end

  def other_user(current_user)
    current_user == from_user ? to_user : from_user
  end

  def to_s
    "Conversation between #{from_user} and #{to_user}"
  end

  private

    def broadcast_message_to_other_user(current_user)
      other = other_user(current_user)
      stream_name = "direct_message_#{id}_user_#{other.id}"
      typing_id = "typing-indicator-#{id}"
      broadcast_msg = chat_message_from_log(log.last, other)

      Turbo::StreamsChannel.broadcast_remove_to(stream_name, target: typing_id)

      Turbo::StreamsChannel.broadcast_append_to(
        stream_name,
        target: chat_list_id,
        partial: broadcast_msg.template,
        locals: broadcast_msg.locals
      )

      Turbo::StreamsChannel.broadcast_action_to(stream_name, action: :scroll_bottom, target: 'scroll-container')
    end
end
