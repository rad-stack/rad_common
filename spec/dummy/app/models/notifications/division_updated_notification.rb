module Notifications
  class DivisionUpdatedNotification < ::NotificationType
    def auth_mode
      :absolute_user
    end

    def absolute_user_id
      payload.owner_id
    end
  end
end
