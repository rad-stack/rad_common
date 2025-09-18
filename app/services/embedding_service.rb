require 'openai'

class EmbeddingService
  def self.generate(text)
    client = OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)

    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: text.slice(0, 8192)
      }
    )
    response.dig('data', 0, 'embedding')
  end

  def self.enabled?
    RadConfig.open_ai_api_key.present?
  end
end
