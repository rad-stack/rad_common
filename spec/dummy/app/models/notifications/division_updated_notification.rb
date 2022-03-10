module Notifications
  class DivisionUpdatedNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      [payload.owner_id]
    end

    def mailer_class
      'DivisionMailer'
    end

    def mailer_method
      'division_updated'
    end
  end
end
