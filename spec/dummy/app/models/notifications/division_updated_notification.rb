module Notifications
  class DivisionUpdatedNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      [payload.owner_id]
    end
  end
end
