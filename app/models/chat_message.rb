class ChatMessage
  attr_reader :direction, :user_name, :message, :chat_date, :user

  def initialize(direction:, user_name:, message:, chat_date:, user: nil)
    @direction = direction
    @user_name = user_name
    @message = message
    @chat_date = chat_date
    @user = user
  end

  def template
    "chat/message_#{direction}"
  end

  def to_partial_path
    template
  end

  def locals
    { message: message, user_name: user_name, chat_date: chat_date, user: user }
  end
end
