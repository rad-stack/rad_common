module LLMChatsHelper
  VISIBLE_ROLES = %w[user assistant].freeze

  def ask_basic_question_btn
    return unless policy(LLMChat).new?

    button_tag(icon(:comment, 'Ask Assistant?'),
               class: 'btn btn-primary btn-sm',
               'data-bs-target' => '#basic-question-modal',
               'data-bs-toggle' => 'offcanvas')
  end

  def llm_chat_logs(llm_chat)
    return [] if llm_chat.log.blank?

    raw_data = llm_chat.log
    raw_data.select { |message| VISIBLE_ROLES.include?(message['role']) && message['content'].present? }
  end

  def llm_chat_log_data(llm_chat, log)
    log.symbolize_keys!
    direction = log[:role] == 'user' ? 'left' : 'right'
    user_name = log[:role] == 'user' ? current_user.to_s : llm_chat.assistant_name
    template = "llm_chats/chat_message_#{direction}"
    message = llm_chat.format_text(log[:content])
    { direction: direction, user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: User.first }
  end

  def llm_chat_text_sanitize(text)
    text = remove_context_data(text)
    allowed_tags = Rails::Html::SafeListSanitizer.allowed_tags
    allowed_tags += %w[a]
    allowed_attributes = Rails::Html::SafeListSanitizer.allowed_attributes
    allowed_attributes += %w[href]

    sanitize(text, tags: allowed_tags, attributes: allowed_attributes)
  end

  def remove_context_data(text)
    text.gsub(/CONTEXT_DATA_FOLLOWS.*\z/m, '')
  end
end
