class NotificationSetting < ApplicationRecord
  include Authority::Abilities

  belongs_to :notification_type
  belongs_to :user

  scope :enabled, -> { where(enabled: true) }

  audited associated_with: :user

  def self.settings_for_user(user)
    types = NotificationType.authorized(user).by_name
    settings = []

    types.each do |notification_type|
      settings.push NotificationSetting.find_or_initialize_by(notification_type: notification_type,
                                                              user_id: user.id)
    end

    settings
  end
end
