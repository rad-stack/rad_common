module AssistantSessionsHelper
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
end
