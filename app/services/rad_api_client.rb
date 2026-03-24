class RadApiClient
  class UnsuccessfulRequest < StandardError; end
  class NotFound < StandardError; end

  def initialize(host:, token: nil, basic_auth: nil)
    @token = token
    @host = host
    @basic_auth = basic_auth
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
    RadRetry.perform_request(additional_errors: [UnsuccessfulRequest], raise_original: true) do
      process_response(connection(params: params).get(url))
    end
  end

  private

    def connection(params: {})
      Faraday.new(url: @host, params: params, headers: default_headers) do |faraday|
        faraday.request :authorization, :basic, api_username, api_password
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def default_headers
      headers = {}
      headers[:Authorization] = "Bearer #{@token}" if bearer_auth?
      headers[:Accept] = 'application/json'
      headers['Content-Type'] = 'application/json'
      headers
    end

    def bearer_auth?
      @token.present?
    end

    def basic_auth?
      @basic_auth.present?
    end

    def api_username
      @basic_auth[:username]
    end

    def api_password
      @basic_auth[:password]
    end

    def process_response(response)
      raise NotFound if response.status == 404
      raise UnsuccessfulRequest, response.body unless response.success?

      return if response.body.blank?
      return JSON.parse(response.body) if response.body.is_a?(String)

      response.body
    end
end
