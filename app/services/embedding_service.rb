require 'openai'

class EmbeddingService
  def self.generate(text, record: nil)
    if text.length > RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS
      context = record ? " for #{record.class.name} #{record.id}" : ''
      raise "Text too large to embed#{context}: #{text.length} characters (max #{RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS})"
    end

    client = OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)

    response = RadRetry.perform_request do
      client.embeddings(parameters: { model: RadCommon::OPEN_AI_EMBEDDING_MODEL, input: text })
    end

    response.dig('data', 0, 'embedding')
  end

  def self.enabled?
    RadConfig.open_ai_api_key.present?
  end
end
