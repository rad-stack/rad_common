module Notifications
  class Notification
    def self.authorized(user)
      where_clause = 'security_role_id IN (SELECT security_role_id FROM security_roles_users WHERE user_id = ?)'

      types = NotificationSecurityRole.select(:notification_type)
                                      .distinct(:notification_type)
                                      .where(where_clause, user.id)
                                      .pluck(:notification_type)

      types.sort
    end

    def self.description
      to_s.gsub('Notifications::', '').underscore.titleize.gsub(' Notification', '')
    end

    def notify_list(fatal)
      users = permitted_users
      users = users.where.not(id: NotificationSetting.where(notification_type: notification_type, enabled: false).pluck(:user_id))

      raise 'no users to notify' if fatal && users.count.zero?

      users
    end

    def permitted_users
      where_clause = 'users.id IN (SELECT user_id FROM security_roles_users WHERE security_role_id IN '\
                       '(SELECT security_role_id FROM notification_security_roles WHERE notification_type = ?))'

      User.active.where(where_clause, notification_type)
    end

    private

      def notification_type
        self.class.name
      end

      def notify_user_ids
        notify_list(true).pluck(:id)
      end
  end
end
