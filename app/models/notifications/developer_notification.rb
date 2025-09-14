module Notifications
  class DeveloperNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      [User.developers.pluck(:id)]
    end
  end
end
