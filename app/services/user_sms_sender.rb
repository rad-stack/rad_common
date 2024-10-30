class UserSMSSender < PhoneSMSSender
  def initialize(message, contact_log_from_user_id, to_user_id, media_url, force_opt_out, contact_log_record: nil)
    self.to_user = User.find(to_user_id)

    super(message, contact_log_from_user_id, to_user.mobile_phone, media_url, force_opt_out, contact_log_record: contact_log_record)
  end

  private

    def handle_blacklist
      ActiveRecord::Base.transaction do
        to_user.notification_settings.enabled.where(sms: true).each do |item|
          item.update! sms: false
        end

        to_user.update! mobile_phone: nil
      end

      RadMailer.simple_message(to_user,
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
