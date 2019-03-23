module Notifications
  class Notification
    def self.authorized(user)
      where_clause = 'security_role_id IN (SELECT security_role_id FROM security_roles_users WHERE user_id = ?)'

      NotificationSecurityRole.select(:notification_type)
                              .distinct(:notification_type)
                              .where(where_clause, user.id)
                              .pluck(:notification_type)
    end

    private

      def permitted_users
        where_clause = 'id IN (SELECT user_id FROM security_roles_users WHERE security_role_id IN '\
                       '(SELECT security_role_id FROM notification_security_roles WHERE notification_type = ?))'

        User.where(where_clause, notification_type)
      end

      def notification_type
        self.class.name
      end

      def notify_list
        users = permitted_users
        users = users.where.not(id: NotificationSetting.where(notification_type: notification_type, enabled: false).pluck(:user_id))

        raise 'no users to notify' if users.count.zero?

        users
      end

      def notify_user_ids
        notify_list.pluck(:id)
      end
  end
end
