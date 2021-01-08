class UserSMSSender
  attr_accessor :message, :recipient, :media_url, :exception, :from_number

  def initialize(message, recipient_id, media_url)
    self.message = message
    self.recipient = User.find(recipient_id)
    self.media_url = media_url

    raise "The message to #{recipient} failed: they do not have a mobile phone number." if recipient.mobile_phone.blank?
  end

  def send!
    RadicalRetry.perform_request do
      twilio = RadicalTwilio.new
      self.from_number = twilio.from_number

      if media_url.present?
        twilio.send_mms to: to_number, message: message, media_url: media_url
      else
        twilio.send_sms to: to_number, message: message
      end
    end
  rescue Twilio::REST::RestError => e
    self.exception = e
    raise e.message unless blacklisted?

    handle_blacklist
  end

  private

    def to_number
      "+1#{recipient.mobile_phone.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}"
    end

    def blacklisted?
      exception.message.include?('violates a blacklist rule')
    end

    def handle_blacklist
      body = error_body

      recipient.update! mobile_phone: nil

      RadbearMailer.simple_message(recipient,
                                   "SMS Message from #{I18n.t(:app_name)} Failed",
                                   body,
                                   email_action: email_action).deliver_later
    end

    def error_body
      'The system tried to send you an SMS message but your mobile phone number that we have on '\
      "file #{recipient.mobile_phone}, failed, most likely due to being previously opted out. We have removed "\
      'the mobile phone number from our system to prevent this issue in future communications. If you would like '\
      'to continue to receive text messages, you can add back your mobile number to your user profile, and send the '\
      "message 'YES' to #{from_number}. Please reply to this email with any questions or concerns that you "\
      'might have.'
    end

    def email_action
      { message: 'Click here to update your profile.',
        button_text: 'Update Profile',
        button_url: Rails.application.routes.url_helpers.edit_user_registration_url }
    end
end
