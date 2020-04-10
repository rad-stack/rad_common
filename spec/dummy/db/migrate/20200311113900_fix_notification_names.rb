class FixNotificationNames < ActiveRecord::Migration[6.0]
  def change
    execute "UPDATE notification_types SET type = 'Notifications::InvalidDataWasFoundNotification' WHERE type = 'Notifications::GlobalValidityNotification'"
    execute "UPDATE notification_types SET type = 'Notifications::UserAcceptedInvitationNotification' WHERE type = 'Notifications::UserAcceptsInvitationNotification'"
  end
end
