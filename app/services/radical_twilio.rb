class RadicalTwilio
  def send_sms(to:, message:)
    client.messages.create(from: from_number, to: to, body: message)
  end

  def send_mms(to:, message:, media_url:)
    client.messages.create(from: from_number_mms, to: to, body: message, media_url: media_url)
  end

  def send_robocall(to:, url:)
    client.calls.create(from: from_number, to: to, url: URI::Parser.new.escape(url))
  end

  def self.send_verify_sms(mobile_phone)
    response = RadicalRetry.perform_request(retry_count: 2, raise_original: true) do
      TwilioVerifyService.send_sms_token(mobile_phone)
    end

    response.status == 'pending'
  end

  def self.setup_totp_service(user)
    RadicalRetry.perform_request(retry_count: 2, raise_original: true) do
      TwilioVerifyService.setup_totp_service(user)
    end
  end

  def self.register_totp_service(user, token)
    RadicalRetry.perform_request(retry_count: 2, raise_original: true) do
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
    "(#{phone_number[2, 3]}) #{phone_number[5, 3]}-#{phone_number[8, 4]}"
  end

  private

    def client
      Twilio::REST::Client.new(RadConfig.twilio_account_sid!, RadConfig.twilio_auth_token!)
    end

    def get_phone_number(attribute, mobile)
      converted_phone_number = attribute.gsub(/[^0-9a-z\\s]/i, '')
      mobile ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
    end

    def lookup_number(number, type = nil)
      lookup_client = Twilio::REST::Client.new(RadConfig.twilio_account_sid!, RadConfig.twilio_auth_token!)

      RadicalRetry.perform_request(retry_count: 2, raise_original: true) do
        if type
          lookup_client.lookups.phone_numbers(number).fetch(type: [type])
        else
          lookup_client.lookups.phone_numbers(number).fetch
        end
      end
    end
end
