class NotificationSetting < ApplicationRecord
  include Authority::Abilities

  belongs_to :user

  scope :enabled, -> { where(enabled: true) }

  def notification
    # TODO: move this to the notification class
    notification_type.gsub('Notifications::', '').underscore.titleize.gsub(' Notification', '')
  end
end
