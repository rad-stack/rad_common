class RadicalTwilio
  OPT_OUT_MESSAGE = 'To no longer receive text messages, text STOP'.freeze

  def send_sms(to:, message:)
    client.messages.create(from: from_number, to: to, body: full_body(message))
  end

  def send_mms(to:, message:, media_url:)
    client.messages.create(from: from_number_mms, to: to, body: full_body(message), media_url: media_url)
  end

  def send_robocall(to:, url:)
    client.calls.create(from: from_number, to: to, url: URI.encode(url))
  end

  def self.twilio_enabled?
    if Rails.application.credentials.twilio[:account_sid].blank? &&
       Rails.application.credentials.twilio[:auth_token].blank? &&
       Rails.application.credentials.twilio[:phone_number].blank?

      return false
    end

    if Rails.application.credentials.twilio[:account_sid].present? &&
       Rails.application.credentials.twilio[:auth_token].present? &&
       Rails.application.credentials.twilio[:phone_number].present?

      return true
    end

    raise 'inconsistent twilio config'
  end

  def from_number
    Rails.application.credentials.twilio[:phone_number]
  end

  def from_number_mms
    Rails.application.credentials.twilio[:mms_phone_number]
  end

  def validate_phone_number(phone_number, mobile)
    return unless RadicalTwilio.twilio_enabled?

    # twilio phone number validations that check whether valid mobile # cost half a penny per request

    begin
      response = get_phone_number(phone_number, mobile)
      return 'does not appear to be a valid mobile phone number' if mobile && response.carrier['type'] != 'mobile'

      response.phone_number
    rescue Twilio::REST::RestError, NoMethodError => e
      Rails.logger.info "twilio lookup error: #{e}"
      return 'does not appear to be a valid phone number'
    end

    nil
  end

  private

    def client
      Twilio::REST::Client.new(Rails.application.credentials.twilio[:account_sid],
                               Rails.application.credentials.twilio[:auth_token])
    end

    def full_body(message)
      return "#{message} - #{OPT_OUT_MESSAGE}" unless %w[. ! ?].include?(message[-1])

      "#{message} #{OPT_OUT_MESSAGE}."
    end

    def get_phone_number(attribute, mobile)
      converted_phone_number = attribute.gsub(/[^0-9a-z\\s]/i, '')
      mobile ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
    end

    def lookup_number(number, type = nil)
      lookup_client = Twilio::REST::Client.new(Rails.application.credentials.twilio[:account_sid],
                                               Rails.application.credentials.twilio[:auth_token])

      RadicalRetry.perform_request(retry_count: 2) do
        if type
          lookup_client.lookups.phone_numbers(number).fetch(type: [type])
        else
          lookup_client.lookups.phone_numbers(number).fetch
        end
      end
    end
end
