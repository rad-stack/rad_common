class FixDeveloperNotifications < ActiveRecord::Migration[7.2]
  def change
    return if NotificationType.none?

    %w[Notifications::GlobalValidityRanLongNotification
       Notifications::InvalidDataWasFoundNotification
       Notifications::TwilioErrorThresholdExceededNotification
       Notifications::MissingAuditModelsNotification].each do |item|
      record = NotificationType.find_by(type: item)
      next if record.blank?

      record.update! security_roles: []
    end
  end
end
