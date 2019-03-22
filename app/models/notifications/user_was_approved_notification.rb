module Notifications
  class UserWasApprovedNotification < Notification
    def notify!(subject)
      user = subject.first
      RadbearMailer.user_was_approved(users_except_self(user), user, subject.last).deliver_later
    end

    def default_users
      User.admins
    end

    private

      def users_except_self(user)
        notify_user_ids - [user.id]
      end
  end
end
