require 'openai'

class EmbeddingService
  # TODO: not sure we need tags_liine and notes_omitted
  # TODO: tags is specific to rad gallery photos

  SCHEMA = { type: 'object',
             additionalProperties: false,
             required: %w[narrative tags_line notes_omitted],
             properties: { narrative: { type: 'string', maxLength: 700 },
                           tags_line: { type: 'string', maxLength: 300 },
                           notes_omitted: { type: 'array', items: { type: 'string' } } } }.freeze

  attr_reader :generate_embedding_content

  def initialize(generate_embedding_content)
    @generate_embedding_content = generate_embedding_content
    raise 'wrong type' unless generate_embedding_content.is_a?(Hash)
  end

  def generate
    # TODO: what's this slice doing?

    response = RadRetry.perform_request do
      client.embeddings(parameters: { model: 'text-embedding-3-small', input: summarized_content.slice(0, 8192) })
    end

    response.dig('data', 0, 'embedding')
  end

  def self.enabled?
    RadConfig.open_ai_api_key.present?
  end

  private

    def summarized_content
      # TODO: move these 2 into each embeddable model as they are specific to the project

      sys = <<~TXT
        You are a data-to-text normalizer for a private family photo archive.
        Create a short, factual description using ONLY fields provided.
        Do not guess. Return STRICT JSON per the schema.
      TXT

      rules = <<~TXT
        OUTPUT SCHEMA (strict): see provided JSON Schema.
        STYLE: 1–3 sentences; include people; ISO date; "Subjects:" with 6–10 salient tags; end with "Taken by {name}." if present.
        MISSING: add missing_city/state/country/people/date/tags in notes_omitted.
      TXT

      payload = generate_embedding_content

      resp = client.chat(
        parameters: {
          model: 'gpt-4.1-mini',
          temperature: 0.1,
          response_format: {
            type: 'json_schema',
            json_schema: { name: 'PhotoNarrative', schema: SCHEMA, strict: true }
          },
          messages: [
            { role: 'system', content: sys },
            { role: 'system', content: rules },
            { role: 'user',   content: payload.to_json }
          ]
        }
      )

      JSON.parse(resp.dig('choices', 0, 'message', 'content'))['narrative']
    end

    def client
      @client ||= OpenAI::Client.new(access_token: RadConfig.open_ai_api_key!)
    end
end
