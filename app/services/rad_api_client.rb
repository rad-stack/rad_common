class RadApiClient
  class UnsuccessfulRequest < StandardError; end
  class NotFound < StandardError; end

  def initialize(host:, token: nil, basic_auth: nil, service_name: nil, credential_key_name: nil)
    @token = token
    @host = host
    @basic_auth = basic_auth
    @service_name = service_name || self.class.name
    @credential_key_name = credential_key_name
  end

  def post(url:, payload: nil)
    response = with_logging(:POST, url, request_body: payload) do
      connection.post(url, payload&.to_json)
    end

    process_response(response)
  end

  def patch(url:, payload: nil)
    response = with_logging(:PATCH, url, request_body: payload) do
      connection.patch(url, payload&.to_json)
    end

    process_response(response)
  end

  def delete(url:)
    response = with_logging(:DELETE, url) do
      connection.delete(url)
    end

    process_response(response)
  end

  def get(url:, params: {})
    RadRetry.perform_request(additional_errors: [UnsuccessfulRequest], raise_original: true) do
      response = with_logging(:GET, url) do
        connection(params: params).get(url)
      end

      process_response(response)
    end
  end

  private

    def with_logging(http_method, url, request_body: nil)
      full_url = "#{@host}#{url}"
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      response = nil

      begin
        response = yield
      rescue StandardError => e
        log_failed_request(http_method, full_url, request_body, start_time, e)
        raise
      end

      log_completed_request(http_method, full_url, request_body, start_time, response)
      response
    end

    def log_failed_request(http_method, full_url, request_body, start_time, error)
      duration = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round(2)

      ApiLog.create!(service_name: @service_name,
                     http_method: http_method.to_s,
                     url: full_url,
                     request_headers: ApiLog.sanitize_headers(default_headers),
                     request_body: request_body,
                     success: false,
                     error_message: error.message.truncate(500),
                     credential_key_name: @credential_key_name,
                     duration_ms: duration)
    rescue StandardError => e
      Rails.logger.error("Failed to log API request: #{e.message}")
    end

    def log_completed_request(http_method, full_url, request_body, start_time, response)
      duration = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round(2)

      ApiLog.create!(service_name: @service_name,
                     http_method: http_method.to_s,
                     url: full_url,
                     request_headers: ApiLog.sanitize_headers(default_headers),
                     request_body: request_body,
                     response_status: response.status,
                     response_headers: ApiLog.sanitize_headers(response.headers.to_h),
                     response_body: ApiLog.truncate_body(response.body),
                     success: response.success?,
                     credential_key_name: @credential_key_name,
                     duration_ms: duration)
    rescue StandardError => e
      Rails.logger.error("Failed to log API response: #{e.message}")
    end

    def connection(params: {})
      Faraday.new(url: @host, params: params, headers: default_headers) do |faraday|
        faraday.request :authorization, :basic, api_username, api_password if basic_auth?
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
