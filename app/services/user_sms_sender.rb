class UserSMSSender
  attr_accessor :message, :from_user_id, :to_user, :media_url, :exception, :twilio

  def initialize(message, from_user_id, to_user_id, media_url)
    self.message = message
    self.from_user_id = from_user_id
    self.to_user = User.find(to_user_id)
    self.media_url = media_url
    self.twilio = RadicalTwilio.new

    raise "The message to #{to_user} failed: they do not have a mobile phone number." if to_user.mobile_phone.blank?
  end

  def send!
    RadicalRetry.perform_request do
      if mms?
        twilio.send_mms to: to_number, message: message, media_url: media_url
      else
        twilio.send_sms to: to_number, message: message
      end

      log_event true
    end
  rescue Twilio::REST::RestError => e
    self.exception = e
    raise e.message unless blacklisted?

    handle_blacklist
  end

  def from_number
    mms? ? twilio.from_number_mms : twilio.from_number
  end

  private

    def mms?
      media_url.present?
    end

    def to_number
      "+1#{to_user.mobile_phone.gsub('(', '').gsub(')', '').gsub('-', '').gsub(' ', '')}"
    end

    def blacklisted?
      exception.message.include?('violates a blacklist rule')
    end

    def handle_blacklist
      log_event false

      to_user.update! mobile_phone: nil

      RadbearMailer.simple_message(to_user,
                                   "SMS Message from #{Rails.configuration.rad_common[:app_name]} Failed",
                                   error_body,
                                   email_action: email_action).deliver_later
    end

    def error_body
      'The system tried to send you an SMS message but your mobile phone number that we have on '\
      "file #{to_user.mobile_phone}, failed, most likely due to being previously opted out. We have removed "\
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

    def log_event(success)
      TwilioLog.create! to_number: to_number,
                        from_number: from_number,
                        to_user: to_user,
                        from_user_id: from_user_id,
                        message: message,
                        media_url: media_url,
                        success: success
    end
end
