class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notification_type
  belongs_to :record, polymorphic: true, optional: true

  scope :unread, -> { where(unread: true) }
  scope :active, lambda {
    unread.where('snooze_until IS NULL OR snooze_until <= ?', DateTime.current) if column_names.include?('snooze_until')
  }
  scope :recent_first, -> { order(id: :desc) }

  strip_attributes

  def active?
    return unread? unless self.class.column_names.include?('snooze_until')

    unread? && (snooze_until.nil? || snooze_until <= DateTime.current)
  end
end
