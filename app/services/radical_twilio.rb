class RadicalTwilio
  attr_accessor :current_from_number

  def initialize
    self.current_from_number = next_phone_number
  end

  def send_sms(to:, message:)
    client.messages.create(from: current_from_number, to: to, body: full_body(message))
  end

  def send_mms(to:, message:, media_url:)
    client.messages.create(from: current_from_number, to: to, body: full_body(message), media_url: media_url)
  end

  def send_robocall(to:, url:)
    client.calls.create(from: current_from_number, to: to, url: URI.encode(url))
  end

  def self.twilio_enabled?
    if ENV['TWILIO_ACCOUNT_SID'].blank? && ENV['TWILIO_AUTH_TOKEN'].blank? && ENV['TWILIO_PHONE_NUMBERS'].blank?
      return false
    end

    if ENV['TWILIO_ACCOUNT_SID'].present? && ENV['TWILIO_AUTH_TOKEN'].present? && ENV['TWILIO_PHONE_NUMBERS'].present?
      return true
    end

    raise 'inconsistent twilio config'
  end

  private

    def client
      Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))
    end

    def twilio_phone_numbers
      ENV['TWILIO_PHONE_NUMBERS']&.split(',')
    end

    def next_phone_number
      return if twilio_phone_numbers.blank?
      return twilio_phone_numbers.first if twilio_phone_numbers.count == 1

      company = Company.main
      num_of_nums = twilio_phone_numbers.length
      return nil if num_of_nums.zero?

      return twilio_phone_numbers[0] if num_of_nums == 1

      next_number = twilio_phone_numbers[company.current_phone]

      if company.current_phone < (num_of_nums - 1)
        company.update(current_phone: (company.current_phone + 1))
      else
        company.update(current_phone: 0)
      end

      next_number
    end

    def full_body(message)
      "#{message} - Reply STOP to unsubscribe"
    end
end
