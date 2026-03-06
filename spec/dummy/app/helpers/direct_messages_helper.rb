module DirectMessagesHelper
  def direct_message_log_list(direct_message)
    return [] if direct_message.log.blank?

    direct_message.log.map { |log| direct_message_log_entry(log.symbolize_keys) }
  end

  def direct_message_log_entry(log)
    is_current_user = log[:user_id].to_s == current_user.id.to_s
    user_name = is_current_user ? current_user.to_s : User.find(log[:user_id]).to_s

    { direction: 'left', user_name: user_name, template: 'chat/message_left',
      message: log[:content], chat_date: log[:chat_date], user: (is_current_user ? current_user : nil) }
  end
end
