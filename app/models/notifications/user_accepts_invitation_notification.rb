module Notifications
  class UserAcceptsInvitationNotification < ::NotificationType
    def mailer_subject
      'User Accepted'
    end

    def mailer_message
      "#{payload} has accepted the invitation to join #{app_name}."
    end

    def mailer_options
      { email_action: { message: 'Click here to view the user.',
                        button_text: 'View',
                        button_url: Rails.application.routes.url_helpers.user_url(payload) } }
    end

    def sms_content
      feed_content
    end

    private

      def app_name
        payload.internal? ? I18n.t(:app_name) : I18n.t(:portal_app_name)
      end
  end
end
