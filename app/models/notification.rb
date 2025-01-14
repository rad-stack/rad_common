class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notification_type
  belongs_to :record, polymorphic: true, optional: true

  scope :unread, -> { where(unread: true) }
  scope :active, -> { unread.where('snooze_until IS NULL OR snooze_until <= ?', DateTime.current) }
  scope :recent_first, -> { order(id: :desc) }

  strip_attributes

  def active?
    unread? && (snooze_until.nil? || snooze_until <= DateTime.current)
  end
end
