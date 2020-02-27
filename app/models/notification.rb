class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notification_type

  has_rich_text :content

  # TODO: limiting to 100 for now, routing doesn't work when paging with kaminari for engine routes
  scope :unread, -> { where(unread: true).limit(100) }
  scope :recent_first, -> { order(id: :desc).limit(100) }

  validates :content, presence: true
end
