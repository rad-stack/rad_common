class NotificationSetting < ApplicationRecord
  include Authority::Abilities

  belongs_to :user

  scope :enabled, -> { where(enabled: true) }

  def notification
    notification_type.constantize
  end
end
