module AssistantSessionsHelper
  VISIBLE_ROLES = %w[user assistant].freeze

  def ask_basic_question_btn
    return unless policy(AssistantSession).new?

    button_tag(icon(:comment, 'Ask Assistant?'),
               class: 'btn btn-primary btn-sm',
               'data-bs-target' => '#basic-question-modal',
               'data-bs-toggle' => 'offcanvas')
  end

  def logs_for_session(assistant_session)
    return [] if assistant_session.log.nil?

    assistant_session.log
  end

  def assistant_session_logs(assistant_session)
    return [] if assistant_session.log.blank?

    raw_data = assistant_session.log
    raw_data.select { |message| VISIBLE_ROLES.include?(message['role']) && message['content'].present? }
  end

  def assistant_session_log_data(assistant_session, log)
    log.symbolize_keys!
    direction = log[:role] == 'user' ? 'left' : 'right'
    user_name = log[:role] == 'user' ? current_user.to_s : assistant_session.assistant_name
    template = "assistant_sessions/chat_message_#{direction}"
    message = assistant_session.format_message(log[:content])
    { direction: direction, user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: current_user }
  end

  def assistant_session_text_sanitize(text)
    text = remove_context_data(text)
    text = disable_turbo_links(text)
    allowed_tags = Rails::Html::SafeListSanitizer.allowed_tags
    allowed_tags += %w[a]
    allowed_attributes = Rails::Html::SafeListSanitizer.allowed_attributes
    allowed_attributes += %w[href data-turbo]

    sanitize(text, tags: allowed_tags, attributes: allowed_attributes)
  end

  def disable_turbo_links(text)
    doc = Nokogiri::HTML::DocumentFragment.parse(text)
    doc.css('a').each { |a| a.set_attribute('data-turbo', 'false') }
    doc.to_html.to_s
  end

  def remove_context_data(text)
    text.gsub(/CONTEXT_DATA_FOLLOWS.*\z/m, '')
  end
end
