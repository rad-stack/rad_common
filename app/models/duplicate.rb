class Duplicate < ApplicationRecord
  belongs_to :duplicatable, polymorphic: true

  after_commit :maybe_notify_duplicates, on: :create

  def maybe_notify_duplicates
    return unless score && score >= duplicatable.class.score_upper_threshold

    Notifications::DuplicateFoundUserNotification.main.notify! duplicatable
    Notifications::DuplicateFoundAdminNotification.main.notify! duplicatable
  end
end
