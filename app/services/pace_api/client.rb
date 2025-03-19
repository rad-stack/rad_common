module PaceApi
  class Client
    def initialize(ssl_verify: true, on_error: nil)
      @ssl_verify = ssl_verify
      @on_error = on_error
    end

    def create_object(model_name, attributes)
      url = "/rpc/rest/services/CreateObject/create#{model_name}"
      log_request(action: "CreateObject: #{model_name}", body: attributes, method: 'POST', url: url)
      response = api_client.post(url) do |req|
        req.body = attributes.to_json
      end

      parse_response(response)
    end

    def find_object(type, xpath)
      raise ArgumentError, "Missing the required parameter 'type' when calling FindObjectsApi.find" if type.nil?
      raise ArgumentError, "Missing the required parameter 'xpath' when calling FindObjectsApi.find" if xpath.nil?

      query_params = { type: type, xpath: xpath }

      url = '/rpc/rest/services/FindObjects/find'
      log_request(action: "FindObject: type: #{type} xpath: #{xpath}",
                  query_params: query_params, body: {}, method: 'GET', url: url)
      response = api_client.get(url, query_params)
      parsed_response = parse_response(response)

      return parsed_response if parsed_response.present?


      report_error("The following #{type} is missing from Pace: #{xpath}")
      # TODO: make this notification standard?
      # Notifications::MissingRecordInPaceNotification.main(import_record: @facilis_import, type: type).notify!
      raise "#{type} not found for xpath: #{xpath}"
    end

    def read_object(type, primary_key)
      raise "missing primary key for #{type}" if primary_key.blank?

      query_params = { primaryKey: primary_key }
      url = "/rpc/rest/services/ReadObject/read#{type}"
      log_request(action: "ReadObject: #{type}", query_params: query_params, body: {}, method: 'POST', url: url)
      RadRetry.perform_request(additional_errors: [PaceApi::PaceResponseError]) do
        response = api_client.post(url) { |req| req.params = query_params }
        parse_response(response)
      end
    end

    def update_object(model_name, attributes)
      url = "/rpc/rest/services/UpdateObject/update#{model_name}"
      log_request(action: "UpdateObject: #{model_name}", body: attributes, method: 'POST', url: url)
      response = api_client.post(url) do |req|
        req.body = attributes.to_json
      end

      parse_response(response)
    end

    def invoke_action(action:, model: nil, primary_key_attr: nil, primary_key_value: nil, body: nil,
                      retry_pace_errors: false)
      query_params = {}
      query_params[primary_key_attr] = primary_key_value if primary_key_attr.present?
      additional_errors = retry_pace_errors ? [PaceApi::PaceResponseError] : []
      url = "/rpc/rest/services/InvokeAction/#{action}"

      log_request(action: "Invoking action: #{action}",
                  query_params: query_params, body: body, method: 'POST', url: url)
      RadRetry.perform_request(additional_errors: additional_errors) do
        response = api_client.post(url, query_params) do |req|
          req.params = query_params if query_params.present?
          req.body = body.to_json if body
        end

        parse_response(response, model)
      end
    end

    def self.base_url
      "https://#{pace_api_settings[:host]}"
    end

    def self.escape_for_xpath(string)
      return "''" if string.empty?
      return "\"#{string}\"" if string.include?("'")

      "'#{string}'"
    end

    def self.pace_api_settings
      RadConfig.config_item!(:pace_api)
    end

    def simple_test
      url = '/rpc/rest/services/FindObjects/find'
      query_params = { type: 'Customer', xpath: "@id = 'HOUSE'" }
      log_request(action: 'Simple Test', query_params: query_params, body: {}, method: 'GET', url: url)
      response = api_client.get(url, query_params)
      parse_response(response)
    end

    private

    def api_client
      @api_client ||= Faraday.new(url: base_api_url, proxy: proxy_url) do |faraday|
        faraday.request :authorization, :basic, pace_api_username, pace_api_password
        faraday.headers['Accept'] = 'application/json'
        faraday.headers['Content-Type'] = 'application/json'
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.ssl.verify = @ssl_verify
        faraday.adapter Faraday.default_adapter
      end
    end

    def pace_api_username
      RadConfig.secret_config_item!(:pace_api_username)
    end

    def pace_api_password
      RadConfig.secret_config_item!(:pace_api_password)
    end

    def log_request(action:, body:, method:, url:, query_params: nil)
      Rails.logger.debug do
        "#{action}, url: #{url} query params: #{query_params}, method: #{method} body: #{to_formatted_json(body)}"
      end
    end

    def to_formatted_json(object)
      return if object.blank?

      JSON.pretty_generate(JSON.parse(object.to_json))
    end

    def base_api_url
      "#{PaceApi::Client.base_url}/rpc/rest/services"
    end

    def parse_response(response, return_type = nil)
      str = "Sending Request.... \n"
      str += "Request Method: #{response.env.method}\n"
      str += "Request URL: #{response.env.url}"
      str += "Request Headers: #{response.env.request_headers}\n"
      str += "Request Body: #{response.env.body}\n"

      str += "Response Status: #{response.status}\n"
      str += "Response Headers: #{response.headers}\n"
      str += "Response Body: #{response.body}\n"
      Rails.logger.info(str)
      puts str

      unless response.success?
        raise PaceResponseError, "Request failed with status: #{response.status}, body: #{response.body}"
      end

      parsed_response = return_type.present? ? response.body[return_type] : response.body
      Rails.logger.debug { "Response: #{to_formatted_json(parsed_response)}" }
      parsed_response
    end

    def headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    def proxy_url
      RadConfig.secret_config_item!(:quota_guard_url) if Rails.env.production?

      RadConfig.secret_config_item(:quota_guard_url)
    end

    def report_error(message)
      return unless @on_error

      @on_error.call(message)
    end
  end
end
