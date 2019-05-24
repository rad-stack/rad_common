module Notifications
  class UserAcceptsInvitationNotification < ::Notification
    def notify!(subject)
      options = { email_action: { message: 'Click here to view the user.',
                                  button_text: 'View',
                                  button_url: Rails.application.routes.url_helpers.user_url(subject) } }

      body = "#{subject} has accepted the invitation to join #{I18n.t(:app_name)}."
      RadbearMailer.simple_message(notify_user_ids, 'User Accepted', body, options).deliver_later
    end
  end
end
