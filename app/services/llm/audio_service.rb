module LLM
  class AudioService
    DEFAULT_VOICE = 'alloy'.freeze

    def generate_speech(text, voice: DEFAULT_VOICE)
      RadRetry.perform_request do
        openai_client.audio.speech(
          parameters: {
            model: RadCommon::OPEN_AI_TTS_MODEL,
            input: text,
            voice: voice,
            response_format: 'mp3',
          }
        )
      end
    end

    private

      def openai_client
        @openai_client ||= OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)
      end
  end
end
