class UserNotification < ApplicationRecord
  include Authority::Abilities

  belongs_to :user
  belongs_to :notification

  scope :enabled, -> { where(enabled: true) }
end
