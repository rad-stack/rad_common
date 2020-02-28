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

        def mailer_subject(_subject)
          'User Accepted'
        end

        def mailer_message(subject)
          "#{subject} has accepted the invitation to join #{I18n.t(:app_name)}."
        end

        def mailer_options(subject)
          { email_action: { message: 'Click here to view the user.',
                            button_text: 'View',
                            button_url: Rails.application.routes.url_helpers.user_url(subject) } }
        end

        def feed_content(subject)
          "#{subject} has accepted the invitation to join."
        end

        def feed_record(subject)
          subject
        end

        def sms_content(subject)
          feed_content(subject)
        end

        def exclude_user_ids(_subject)
          []
        end
    end
  end
end
