class FixSendgridNotification < ActiveRecord::Migration[6.1]
  def change
    return unless NotificationType.exists?

    record = NotificationType.find_by(type: 'Notifications::SendgridEmailStatusNotification')
    return if record.blank?

    record.notification_security_roles.destroy_all
  end
end
