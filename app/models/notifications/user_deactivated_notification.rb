module Notifications
  class UserDeactivatedNotification < ::NotificationType
    def mailer_message
      "#{payload} was deactivated from #{RadConfig.app_name!}."
    end
  end
end
