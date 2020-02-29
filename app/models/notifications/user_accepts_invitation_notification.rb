module Notifications
  class UserAcceptsInvitationNotification < ::NotificationType
    class << self
      protected

        def mailer_class
          'RadbearMailer'
        end

        def mailer_method
          'simple_message'
        end

        def mailer_subject(_payload)
          'User Accepted'
        end

        def mailer_message(payload)
          "#{payload} has accepted the invitation to join #{I18n.t(:app_name)}."
        end

        def mailer_options(payload)
          { email_action: { message: 'Click here to view the user.',
                            button_text: 'View',
                            button_url: Rails.application.routes.url_helpers.user_url(payload) } }
        end

        def feed_content(payload)
          "#{payload} has accepted the invitation to join."
        end

        def feed_record(payload)
          payload
        end

        def sms_content(payload)
          feed_content(payload)
        end

        def exclude_user_ids(_payload)
          []
        end
    end
  end
end
