module Notifications
  class InactiveUserAlertNotification < ::NotificationType
    def mailer_message
      "The user #{user} with email #{user.email} has an expired account due to inactivity and is attempting " \
        "to #{reason}. You may want to get in touch with this user and/or re-activate their account if appropriate."
    end

    def feed_content
      mailer_message
    end

    def sms_content
      "#{mailer_message}: #{subject_url}"
    end

    def subject_record
      user
    end

    private

      def reason
        return 'reset their password' if method_name == 'send_reset_password_instructions'
        return 'sign in' if method_name == 'sign_in_attempt'

        raise "invalid method_name #{method_name}"
      end

      def user
        payload[:user]
      end

      def method_name
        payload[:method_name].to_s
      end
  end
end
