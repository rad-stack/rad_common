class RadApiClient
  class UnsuccessfulRequest < StandardError; end

  def initialize(host:, token: nil)
    @token = token
    @host = host
  end

  def post(url:, payload: nil)
    process_response(connection.post(url, payload&.to_json))
  end

  def patch(url:, payload: nil)
    process_response(connection.patch(url, payload&.to_json))
  end

  def delete(url:)
    process_response(connection.delete(url))
  end

  def get(url:, params: {})
    RadRetry.perform_request(additional_errors: [UnsuccessfulRequest]) do
      process_response(connection(params: params).get(url))
    end
  end

  private

  def connection(params: {})
    Faraday.new(
      url: @host,
      params: params,
      headers: default_headers
    )
  end

  def default_headers
    headers = {}
    headers[:Authorization] = "Bearer #{@token}"
    headers[:Accept] = 'application/json'
    headers['Content-Type'] = 'application/json'
    headers
  end

  def process_response(response)
    raise UnsuccessfulRequest, response.body unless response.success?

    JSON.parse(response.body) if response.body.present?
  end
end
