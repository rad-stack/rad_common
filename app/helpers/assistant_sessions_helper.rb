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
    direction = log[:role] == 'user' ? 'right' : 'left'
    user_name = log[:role] == 'user' ? current_user.to_s : assistant_session.assistant_name
    template = "assistant_sessions/chat_message_#{direction}"
    message = assistant_session.format_message(log[:content])
    { direction: direction, user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: current_user }
  end

  def show_page_log_data(assistant_session, log)
    log.symbolize_keys!
    direction = log[:role] == 'user' ? 'right' : 'left'
    user_name = if log[:role] == 'user'
                  assistant_session.user.to_s
                else
                  safe_assistant_name(assistant_session)
                end
    template = "assistant_sessions/chat_message_#{direction}"
    message = safe_format_message(assistant_session, log[:content])
    { direction: direction, user_name: user_name, template: template, message: message,
      chat_date: log[:chat_date], user: assistant_session.user }
  end

  def safe_assistant_name(assistant_session)
    assistant_session.assistant_name
  rescue RuntimeError
    'Assistant'
  end

  def safe_format_message(assistant_session, content)
    assistant_session.format_message(content)
  rescue RuntimeError
    content
  end

  def assistant_session_text_sanitize(text)
    # Handle case where content is an array (e.g., OpenAI content parts)
    text = text.map { |part| part.is_a?(Hash) ? part['text'] : part }.join if text.is_a?(Array)
    text = text.to_s

    text = remove_context_data(text)
    text = remove_mention_context(text)
    text = format_mentions(text)
    text = disable_turbo_links(text)
    allowed_tags = Rails::Html::SafeListSanitizer.allowed_tags
    allowed_tags += %w[a span]
    allowed_attributes = Rails::Html::SafeListSanitizer.allowed_attributes
    allowed_attributes += %w[href data-turbo data-type data-id]

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

  def format_mentions(text)
    text.gsub(LLM::MentionParser::MENTION_PATTERN) do |_match|
      type = ::Regexp.last_match(1)
      id = ::Regexp.last_match(2)
      label = ::Regexp.last_match(3)
      content_tag(:span, "@#{label}", class: 'mention', data: { type: type, id: id })
    end
  end

  def remove_mention_context(text)
    text.gsub(/\n\nMENTIONED_ENTITIES:.*\z/m, '')
  end

  # Groups logs into Q&A pairs: user question + tool calls + assistant answer
  def group_logs_into_qa_pairs(all_logs)
    pairs = []
    current_pair = { question: nil, answer: nil, tool_calls: [] }

    all_logs.each do |log|
      log.symbolize_keys!
      pairs, current_pair = process_qa_log(log, pairs, current_pair)
    end

    # Don't forget the last pair
    pairs << current_pair if current_pair[:question]

    pairs
  end

  def process_qa_log(log, pairs, current_pair)
    if log[:role] == 'user' && log[:content].present?
      pairs << current_pair if current_pair[:question]
      current_pair = { question: log, answer: nil, tool_calls: [] }
    elsif log[:role] == 'assistant' && log[:content].present?
      current_pair[:answer] = log
      current_pair[:usage] = log[:usage]&.transform_keys(&:to_sym)
    elsif log[:type].present?
      current_pair[:tool_calls] << log
    end

    [pairs, current_pair]
  end

  def total_token_usage(qa_pairs)
    qa_pairs.each_with_object({ input: 0, output: 0 }) do |pair, totals|
      next unless pair[:usage]
      totals[:input] += pair[:usage][:input_tokens].to_i
      totals[:output] += pair[:usage][:output_tokens].to_i
    end
  end
  
  def format_json(value)
    return value if value.blank?

    if value.is_a?(String)
      begin
        parsed = JSON.parse(value)
        JSON.pretty_generate(parsed)
      rescue JSON::ParserError
        value
      end
    else
      JSON.pretty_generate(value)
    end
  rescue StandardError
    value.to_s
  end
end
