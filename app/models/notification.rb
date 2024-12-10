class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notification_type
  belongs_to :record, polymorphic: true, optional: true

  scope :unread, -> { where(unread: true) }
  scope :recent_first, -> { order(id: :desc) }

  strip_attributes
end
