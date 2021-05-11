class RadicalTwilio
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
    if ENV['TWILIO_ACCOUNT_SID'].blank? && ENV['TWILIO_AUTH_TOKEN'].blank? && ENV['TWILIO_PHONE_NUMBER'].blank?
      return false
    end

    if ENV['TWILIO_ACCOUNT_SID'].present? && ENV['TWILIO_AUTH_TOKEN'].present? && ENV['TWILIO_PHONE_NUMBER'].present?
      return true
    end

    raise 'inconsistent twilio config'
  end

  def from_number
    ENV.fetch('TWILIO_PHONE_NUMBER')
  end

  def from_number_mms
    ENV.fetch('TWILIO_MMS_PHONE_NUMBER')
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
      Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))
    end

    def full_body(message)
      return "#{message} - Reply STOP to unsubscribe" unless %w[. ! ?].include?(message[-1])

      "#{message} Reply STOP to unsubscribe."
    end

    def get_phone_number(attribute, mobile)
      converted_phone_number = attribute.gsub(/[^0-9a-z\\s]/i, '')
      mobile ? lookup_number(converted_phone_number, 'carrier') : lookup_number(converted_phone_number)
    end

    def lookup_number(number, type = nil)
      lookup_client = Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))

      RadicalRetry.perform_request(retry_count: 2) do
        if type
          lookup_client.lookups.phone_numbers(number).fetch(type: [type])
        else
          lookup_client.lookups.phone_numbers(number).fetch
        end
      end
    end
end
