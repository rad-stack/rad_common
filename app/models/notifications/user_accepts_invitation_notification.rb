module Notifications
  class UserAcceptsInvitationNotification < ::NotificationType
    class << self
      protected

        def notify_email!(subject)
          options = { email_action: { message: 'Click here to view the user.',
                                      button_text: 'View',
                                      button_url: Rails.application.routes.url_helpers.user_url(subject) } }

          body = "#{subject} has accepted the invitation to join #{I18n.t(:app_name)}."

          RadbearMailer.simple_message(notify_user_ids(subject, :email),
                                       'User Accepted',
                                       body,
                                       options).deliver_later
        end

        def feed_content(subject)
          # TODO: add link
          "#{subject} has accepted the invitation to join."
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
