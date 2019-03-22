module Notifications
  class Notification
    private

      def notify_list
        users = default_users
        users = users.where.not(id: NotificationSetting.where(notification_type: self.class.name, enabled: false).map(&:user_id))

        raise 'no users to notify' if users.count.zero?

        users
      end

      def notify_user_ids
        notify_list.pluck(:id)
      end
  end
end
