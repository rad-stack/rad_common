require 'openai'

class EmbeddingService
  # This is somewhat of an arbitrary number, to be more exact we need to us tokenizer, potentially a chunker to break up
  # embedding into chunks. We then would need to know what tokenizer our model is using.
  MAX_TEXT_CONTENT_LENGTH = 8192
  def self.generate(text)
    client = OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)
    text = text.slice(0, MAX_TEXT_CONTENT_LENGTH)

    response = RadRetry.perform_request do
      client.embeddings(parameters: { model: RadCommon::OPEN_AI_EMBEDDING_MODEL, input: text })
    end

    response.dig('data', 0, 'embedding')
  end

  def self.enabled?
    RadConfig.open_ai_api_key.present?
  end
end
