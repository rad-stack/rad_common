class SinchFaxClient
  HOST = 'https://fax.api.sinch.com/v3/projects'.freeze
  DEFAULT_TEST_NUMBER = '(989) 898-9898'.freeze

  delegate :get, :post, to: :api_client

  def send_fax!(to_number:, files:)
    post(url: 'faxes', payload: fax_body(to_number: to_number, files: files))
  end

  def fax_body(to_number:, files:)
    { to: RadTwilio.human_to_twilio_format(to_number),
      from: SinchFaxClient.from_number, files: file_objects(files),
      callbackUrl: status_callback_url, callbackUrlContentType: 'application/json' }
  end

  def status_callback_url
    "#{protocol}://#{host_name}/sinch_statuses"
  end

  def protocol
    Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
  end

  def host_name
    Rails.env.production? || Rails.env.staging? ? RadConfig.host_name! : 'example.com'
  end

  def self.from_number
    RadConfig.secret_config_item! :sinch_default_from_number
  end

  private

    def api_client
      @api_client ||= RadApiClient.new(host: host_url, basic_auth: { username: access_key, password: secret_key })
    end

    def file_objects(files)
      files.map { |file| { file: Base64.strict_encode64(file), fileType: 'PDF' } }
    end

    def host_url
      @host_url ||= "#{HOST}/#{project_id}"
    end

    def access_key
      @access_key ||= RadConfig.secret_config_item! :sinch_access_key
    end

    def project_id
      @project_id ||= RadConfig.secret_config_item! :sinch_project_id
    end

    def secret_key
      @secret_key ||= RadConfig.secret_config_item! :sinch_secret_key
    end
end
