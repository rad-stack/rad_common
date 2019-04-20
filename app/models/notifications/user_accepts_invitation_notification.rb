module Notifications
  class UserAcceptsInvitationNotification < Notification
    def notify!(subject)
      body = "#{subject} has accepted the invitation to join #{I18n.t(:app_name)}."
      RadbearMailer.simple_message(notify_user_ids, 'User Accepted', body).deliver_later
    end
  end
end
