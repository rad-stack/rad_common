module Notifications
  class UserHasOpenInvitationNotification < ::NotificationType
    def mailer_message
      "The user named #{user} with email of #{user.email} was invited but is struggling to complete their " \
        "onboarding process. They have tried to #{reason} but that operation is not applicable here, they need to " \
        'accept their invitation. Perhaps someone should get in touch with the user and/or resend their invite so ' \
        'they can properly accept it.'
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
        return 'resend their confirmation instructions' if method_name == 'pending_any_confirmation'

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
