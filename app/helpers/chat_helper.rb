module ChatHelper
  def chat_text_sanitize(text)
    text = chat_disable_turbo_links(text)
    allowed_tags = Rails::Html::SafeListSanitizer.allowed_tags + %w[a]
    allowed_attributes = Rails::Html::SafeListSanitizer.allowed_attributes + %w[href data-turbo]

    sanitize(text, tags: allowed_tags, attributes: allowed_attributes)
  end

  def chat_log_data(log, current_user_id:, current_user_name:, responder_name:, current_user_record: nil,
                    responder_record: nil)
    log.symbolize_keys!
    is_current_user = log[:user_id].to_s == current_user_id.to_s
    user_name = is_current_user ? current_user_name : responder_name
    user = is_current_user ? current_user_record : responder_record

    { direction: 'left', user_name: user_name, template: 'chat/message_left',
      message: log[:content], chat_date: log[:chat_date], user: user }
  end

  def chat_open_btn(target_id, label: 'Chat', icon_name: :comment, btn_class: 'btn btn-primary btn-sm')
    button_tag(icon(icon_name, label),
               class: btn_class,
               'data-bs-target' => "##{target_id}",
               'data-bs-toggle' => 'offcanvas')
  end

  private

    def chat_disable_turbo_links(text)
      doc = Nokogiri::HTML::DocumentFragment.parse(text)
      doc.css('a').each { |a| a.set_attribute('data-turbo', 'false') }
      doc.to_html.to_s
    end
end
