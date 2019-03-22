module Notifications
  class GlobalValidityNotification < Notification
    def notify!(subject)
      RadbearMailer.global_validity(notify_user_ids, subject).deliver_later
    end

    def default_users
      User.super_admins
    end
  end
end
