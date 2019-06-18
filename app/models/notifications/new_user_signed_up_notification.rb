module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    def self.notify!(subject)
      RadbearMailer.new_user_signed_up(notify_user_ids, subject).deliver_later
    end
  end
end
