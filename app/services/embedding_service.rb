require 'openai'

class EmbeddingService
  def self.generate(text)
    client = OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)

    response = RadRetry.perform_request do
      client.embeddings(parameters: { model: RadCommon::OPEN_AI_EMBEDDING_MODEL, input: text })
    end

    response.dig('data', 0, 'embedding')
  end

  def self.needs_chunking?(text)
    text.length > RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS
  end

  def self.chunk_text(text)
    chunk_size = RadCommon::OPEN_AI_EMBEDDING_CHUNK_SIZE
    overlap = RadCommon::OPEN_AI_EMBEDDING_CHUNK_OVERLAP

    return [text] unless needs_chunking?(text)

    chunks = []
    position = 0

    while position < text.length
      chunk_end = position + chunk_size
      chunk = text[position...chunk_end]
      chunks << chunk
      position += chunk_size - overlap
    end

    chunks
  end

  def self.enabled?
    RadConfig.open_ai_api_key.present?
  end
end
