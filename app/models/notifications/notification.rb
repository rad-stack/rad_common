module Notifications
  class Notification
    def self.authorized(user)
      where_clause = 'security_role_id IN (SELECT security_role_id FROM security_roles_users WHERE user_id = ?)'

      NotificationSecurityRole.select(:notification_type)
                              .distinct(:notification_type)
                              .where(where_clause, user.id)
                              .pluck(:notification_type)
    end

    def self.description
      to_s.gsub('Notifications::', '').underscore.titleize.gsub(' Notification', '')
    end

    private

      def permitted_users
        where_clause = 'users.id IN (SELECT user_id FROM security_roles_users WHERE security_role_id IN '\
                       '(SELECT security_role_id FROM notification_security_roles WHERE notification_type = ?))'

        User.active.where(where_clause, notification_type)
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
