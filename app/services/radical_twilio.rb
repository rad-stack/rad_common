class RadicalTwilio
  def self.send_sms(from:, to:, message:)
    client.messages.create(from: from, to: to, body: message)
  end

  def self.send_robocall(from:, to:, url:)
    client.calls.create(from: from, to: to, url: URI::encode(url))
  end

  def self.client
    Twilio::REST::Client.new
  end

  def self.twilio_enabled?
    defined?(Twilio).present? && Company.has_attribute?(:twilio_phone_numbers) && client.present?
  end

  def self.next_phone_number
    company = Company.main
    if Rails.env.development?
      ENV['TWILIO_TEST_FROM_PHONE_NUMBER']
    else
      num_of_nums = company.twilio_phone_numbers.length

      return nil if num_of_nums.zero?

      return company.twilio_phone_numbers[0] if num_of_nums == 1

      next_number = company.twilio_phone_numbers[current_phone]

      if company.current_phone < (num_of_nums - 1)
        company.update(current_phone: (current_phone + 1))
      else
        company.update(current_phone: 0)
      end

      next_number
    end
  end
end
