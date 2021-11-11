class RadicalTwilio
  def self.send_sms(from:, to:, message:)
    client.messages.create(from: from, to: to, body: message)
  end

  def self.send_robocall(from:, to:, url:)
    client.calls.create(from: from, to: to, url: URI.encode(url))
  end

  def self.client
    Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))
  end

  def self.twilio_enabled?
    ENV['TWILIO_ACCOUNT_SID'].present? && ENV['TWILIO_AUTH_TOKEN'].present? && ENV['TWILIO_PHONE_NUMBERS'].present?
  end

  def self.twilio_phone_numbers
    ENV['TWILIO_PHONE_NUMBERS']&.split(',')
  end

  def self.next_phone_number
    return if twilio_phone_numbers.blank?
    return twilio_phone_numbers.first if twilio_phone_numbers.count == 1

    company = Company.main
    if Rails.env.development?
      ENV['TWILIO_TEST_FROM_PHONE_NUMBER']
    else
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
  end
end
