class UserSMSSender < PhoneSMSSender
  def initialize(message, from_user_id, to_user_id, media_url, force_opt_out)
    self.to_user = User.find(to_user_id)

    super message, from_user_id, to_user.mobile_phone, media_url, force_opt_out
  end

  private

    def handle_blacklist
      to_user.update! mobile_phone: nil

      RadbearMailer.simple_message(to_user,
                                   "SMS Message from #{RadConfig.app_name!} Failed",
                                   error_body,
                                   email_action: email_action).deliver_later
    end

    def error_body
      'The system tried to send you an SMS message but your mobile phone number that we have on ' \
        "file #{to_mobile_phone}, failed, most likely due to being previously opted out. We have removed " \
        'the mobile phone number from our system to prevent this issue in future communications. If you would like ' \
        'to continue to receive text messages, you can add back your mobile number to your user profile, and send ' \
        "the message 'YES' to #{from_number}. Please reply to this email with any questions or concerns that you " \
        'might have.'
    end

    def email_action
      { message: 'Click here to update your profile.',
        button_text: 'Update Profile',
        button_url: Rails.application.routes.url_helpers.edit_user_registration_url }
    end
end
