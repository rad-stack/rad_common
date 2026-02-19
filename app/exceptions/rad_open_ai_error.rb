class RadOpenAIError < StandardError
  def initialize(error)
    body = error.response[:body]
    body_text = body.is_a?(Hash) ? body.to_json : body.to_s
    super("OpenAI API error (#{error.response[:status]}): #{body_text}")
  end
end
