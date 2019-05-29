module Notifications
  class GlobalValidityNotification < ::NotificationType
    def self.notify!(subject)
      RadbearMailer.global_validity(notify_user_ids, subject).deliver_later
    end
  end
end
