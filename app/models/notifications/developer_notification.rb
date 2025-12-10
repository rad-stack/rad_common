module Notifications
  class DeveloperNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      ids = User.developers.pluck(:id)
      raise 'no users to notify' if ids.blank?

      ids
    end
  end
end
