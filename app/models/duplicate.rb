class Duplicate < ApplicationRecord
  belongs_to :duplicatable, polymorphic: true

  after_commit :maybe_notify_duplicates, on: :create

  def maybe_notify_duplicates
    return if duplicatable.reload.duplicates.blank?

    Notifications::PossibleDuplicateFoundNotification.main.notify!(duplicatable)
    Notifications::PossibleDuplicateAdminNotification.main.notify!(duplicatable)
  end
end
