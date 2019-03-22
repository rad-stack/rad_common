class NotificationSetting < ApplicationRecord
  include Authority::Abilities

  belongs_to :user

  scope :enabled, -> { where(enabled: true) }
end
