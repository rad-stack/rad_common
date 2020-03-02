module Notifications
  class UserAcceptsInvitationNotification < ::NotificationType
    def self.notify!(subject)
      options = { email_action: { message: 'Click here to view the user.',
                                  button_text: 'View',
                                  button_url: Rails.application.routes.url_helpers.user_url(subject) } }

      app_name = subject.internal? ? I18n.t(:app_name) : I18n.t(:portal_app_name)

      body = "#{subject} has accepted the invitation to join #{app_name}."
      RadbearMailer.simple_message(notify_user_ids, 'User Accepted', body, options).deliver_later
    end
  end
end
