class RadTwilio
  def send_sms(to:, message:)
    client.messages.create from: from_number, to: to, body: message, status_callback: status_callback_url
  end

  def send_mms(to:, message:, media_url:)
    client.messages.create from: from_number,
                           to: to,
                           body: message,
                           media_url: media_url,
                           status_callback: status_callback_url
  end

  def send_robocall(to:, url:)
    client.calls.create from: from_number, to: to, url: URI::Parser.new.escape(url)
  end

  def self.send_verify_sms(mobile_phone)
    response = RadRetry.perform_request(retry_count: 2, raise_original: true) do
      TwilioVerifyService.send_sms_token(mobile_phone)
    end

    response.status == 'pending'
  end

  def self.setup_totp_service(user)
    RadRetry.perform_request(retry_count: 2, raise_original: true) do
      TwilioVerifyService.setup_totp_service(user)
    end
  end

  def self.register_totp_service(user, token)
    RadRetry.perform_request(retry_count: 2, raise_original: true) do
      TwilioVerifyService.register_totp_service(user, token)
    end
  end

  def twilio_enabled?
    RadConfig.twilio_enabled?
  end

  def from_number
    RadConfig.twilio_phone_number!
  end

  def from_number_mms
    RadConfig.twilio_mms_phone_number!
  end

  def validate_phone_number(phone_number, mobile)
    return unless twilio_enabled?

    # twilio phone number validations that check whether valid mobile # cost half a penny per request

    begin
      response = get_phone_number(phone_number, mobile)

      if mobile && response.carrier['type'] != 'mobile'
        return 'does not appear to be a valid mobile phone number'
      elsif mobile && !response.country_code.in?(RadConfig.twilio_countries_enabled!)
        return 'country is not supported'
      end

      response.phone_number
    rescue Twilio::REST::RestError, NoMethodError => e
      Rails.logger.info "twilio lookup error: #{e}"
      return 'does not appear to be a valid phone number'
    end

    nil
  end

  def self.human_to_twilio_format(phone_number)
    "+1#{phone_number.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}"
  end

  def self.twilio_to_human_format(phone_number)
    phone_number = phone_number.to_s unless phone_number.is_a?(String)
    phone_number = "+#{phone_number}" if phone_number.size == 11 && phone_number.first != '+'
    raise 'invalid twilio number format' unless phone_number.size == 12

    "(#{phone_number[2, 3]}) #{phone_number[5, 3]}-#{phone_number[8, 4]}"
  end

  def self.strip_phone_number(phone_number)
    return if phone_number.nil?

    phone_number.gsub(/[^0-9a-z\\s]/i, '')
  end

  private

    def client
      Twilio::REST::Client.new(RadConfig.twilio_account_sid!, RadConfig.twilio_auth_token!)
    end

    def get_phone_number(attribute, mobile)
      converted_phone_number = RadTwilio.strip_phone_number(attribute)
      mobile ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
    end

    def lookup_number(number, type = nil)
      lookup_client = Twilio::REST::Client.new(RadConfig.twilio_account_sid!, RadConfig.twilio_auth_token!)

      RadRetry.perform_request(retry_count: 2, raise_original: true) do
        if type
          lookup_client.lookups.phone_numbers(number).fetch(type: [type])
        else
          lookup_client.lookups.phone_numbers(number).fetch
        end
      end
    end

    def status_callback_url
      "#{protocol}://#{host_name}/twilio_statuses"
    end

    def protocol
      Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    end

    def host_name
      Rails.env.production? || Rails.env.staging? ? RadConfig.host_name! : 'example.com'
    end
end
