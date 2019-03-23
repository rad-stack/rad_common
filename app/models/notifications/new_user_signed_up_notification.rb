module Notifications
  class NewUserSignedUpNotification < Notification
    def notify!(subject)
      RadbearMailer.new_user_signed_up(notify_user_ids, subject).deliver_later
    end
  end
end
