module Notifications
  class UserAcceptsInvitationNotification < ::NotificationType
    def mailer_class
      'RadbearMailer'
    end

    def mailer_method
      'simple_message'
    end

    def mailer_subject
      'User Accepted'
    end

    def mailer_message
      "#{payload} has accepted the invitation to join #{I18n.t(:app_name)}."
    end

    def mailer_options
      { email_action: { message: 'Click here to view the user.',
                        button_text: 'View',
                        button_url: Rails.application.routes.url_helpers.user_url(payload) } }
    end

    def feed_content
      "#{payload} has accepted the invitation to join."
    end

    def feed_record
      payload
    end

    def sms_content
      feed_content
    end
  end
end
