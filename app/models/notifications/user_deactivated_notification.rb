module Notifications
  class UserDeactivatedNotification < ::NotificationType
    def mailer_message
      "#{user} was deactivated from #{RadConfig.app_name!} because #{reason}."
    end

    def subject_record
      user
    end

    private

      def user
        payload[:user]
      end

      def reason
        payload[:reason]
      end
  end
end
