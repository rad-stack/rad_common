class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notification_type
  belongs_to :record, polymorphic: true, optional: true

  # TODO: limiting to 100 for now, routing doesn't work when paging with kaminari for engine routes
  scope :unread, -> { where(unread: true).limit(100) }
  scope :recent_first, -> { order(id: :desc).limit(100) }
end
