module DirectMessagesHelper
  def direct_message_log_list(direct_message)
    return [] if direct_message.log.blank?

    direct_message.log.map { |log| direct_message_log_entry(log.symbolize_keys) }
  end

  def direct_message_log_entry(log)
    is_current_user = log[:user_id].to_s == current_user.id.to_s
    user = is_current_user ? current_user : User.find(log[:user_id])

    reactions = (log[:reactions] || {}).transform_values { |ids| ids.map(&:to_i) }

    { direction: 'left', user_name: user.to_s, template: 'chat/message_left',
      message: log[:content], chat_date: log[:chat_date], user: user, reactions: reactions }
  end
end
