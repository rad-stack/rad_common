module Notifications
  class UserWasApprovedNotification < ::NotificationType
    def self.notify!(subject)
      user = subject.first
      RadbearMailer.user_was_approved(users_except_self(user), user, subject.last).deliver_later
    end

    class << self
      private

        def users_except_self(user)
          notify_user_ids - [user.id]
        end
    end
  end
end
