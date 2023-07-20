class Duplicate < ApplicationRecord
  belongs_to :duplicatable, polymorphic: true

  after_commit :maybe_notify_duplicates, on: :create

  def maybe_notify_duplicates
    return if duplicatable.duplicates.blank?

    Notifications::PossibleDuplicateFoundNotification.main.notify!(self)
  end
end
