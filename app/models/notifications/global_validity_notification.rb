module Notifications
  class GlobalValidityNotification < ::Notification
    def notify!(subject)
      RadbearMailer.global_validity(notify_user_ids, subject).deliver_later
    end
  end
end
