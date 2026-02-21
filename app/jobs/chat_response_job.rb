class ChatResponseJob < ApplicationJob
  queue_as :default

  def perform(assistant_session_id, message)
    assistant_session = AssistantSession.find(assistant_session_id)
    service = assistant_session.chat_instance
    begin
      _, messages = service.basic_question(message)
      attach_response_audio(assistant_session, service, messages)
      assistant_session.update!(log: messages, status: 'completed', current_message: nil)
    rescue Faraday::BadRequestError => e
      capture_and_log_error(assistant_session, e)
    rescue StandardError => e
      raise e if Rails.env.development?

      capture_and_log_error(assistant_session, e)
    end
  end

  private

    def capture_and_log_error(assistant_session, error)
      raise error if Rails.env.development?

      Sentry.capture_exception(error)
      error_messages = assistant_session.log ||= []
      error_messages << { role: 'assistant', content: 'An unexpected error occurred' }
      assistant_session.update!(log: error_messages, status: :failed, current_message: nil)
    end

    def attach_response_audio(assistant_session, service, messages)
      return unless service.chat_audio?

      latest_assistant = messages.reverse.find { |m| (m[:role] || m['role']) == 'assistant' }
      return unless latest_assistant

      text = latest_assistant[:content] || latest_assistant['content']
      return if text.blank?

      audio_data = LLM::AudioService.new.generate_speech(text)
      return if audio_data.blank?

      audio_key = "response_#{SecureRandom.hex(8)}.mp3"

      assistant_session.response_audios.attach(
        io: StringIO.new(audio_data),
        filename: audio_key,
        content_type: 'audio/mpeg'
      )

      latest_assistant['audio_key'] = audio_key
    rescue StandardError => e
      Rails.logger.error("Failed to generate chat audio: #{e.message}")
    end
end
