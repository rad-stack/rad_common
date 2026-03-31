class FixNewUserSignedUpNotification < ActiveRecord::Migration[7.2]
  def change
    return if NotificationType.none?

    record = NotificationType.find_by(type: 'Notifications::NewUserSignedUpNotification')
    return if record.blank?

    record.update! security_roles: []
  end
end
