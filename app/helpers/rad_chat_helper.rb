module RadChatHelper
  VISIBLE_CHAT_ROLES = %w[user assistant].freeze

  def rad_chat_logs(chattable)
    messages = chattable.chat_messages_log
    return [] if messages.blank?

    messages.select { |message| VISIBLE_CHAT_ROLES.include?(message['role']) && message['content'].present? }
  end

  def rad_chat_log_data(chattable, log)
    log.symbolize_keys!
    direction = log[:role] == 'user' ? 'left' : 'right'
    user_name = log[:role] == 'user' ? current_user.to_s : chattable.chat_responder_name
    template = "rad_chat/chat_message_#{direction}"
    message = chattable.format_chat_message(log[:content])
    { direction: direction, user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: current_user }
  end

  def rad_chat_text_sanitize(text)
    text = rad_chat_remove_context_data(text)
    text = rad_chat_disable_turbo_links(text)
    allowed_tags = Rails::Html::SafeListSanitizer.allowed_tags
    allowed_tags += %w[a]
    allowed_attributes = Rails::Html::SafeListSanitizer.allowed_attributes
    allowed_attributes += %w[href data-turbo]

    sanitize(text, tags: allowed_tags, attributes: allowed_attributes)
  end

  def rad_chat_disable_turbo_links(text)
    doc = Nokogiri::HTML::DocumentFragment.parse(text)
    doc.css('a').each { |a| a.set_attribute('data-turbo', 'false') }
    doc.to_html.to_s
  end

  def rad_chat_remove_context_data(text)
    text.gsub(/CONTEXT_DATA_FOLLOWS.*\z/m, '')
  end
end
