module DirectMessagesHelper
  def direct_message_chat_log_data(direct_message, log, current_user)
    log.symbolize_keys!
    from_current_user = log[:user_id] == current_user.id
    direction = from_current_user ? 'left' : 'right'
    user_name = log[:user_name] || (from_current_user ? current_user.to_s : direct_message.other_user(current_user).to_s)
    template = "rad_chat/chat_message_#{direction}"
    message = log[:content]
    sender = from_current_user ? current_user : direct_message.other_user(current_user)

    { direction: direction, user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: sender }
  end
end
