class Duplicate < ApplicationRecord
  belongs_to :duplicatable, polymorphic: true

  after_commit :maybe_notify_duplicates, on: :create

  def maybe_notify_duplicates
    return if duplicatable.duplicates_resetting
    return unless score && score >= duplicatable.class.score_upper_threshold

    if duplicatable.created_by.present? && duplicatable.created_by.active? && duplicatable.created_by.internal?
      Notifications::DuplicateFoundUserNotification.main.notify! duplicatable
    end

    Notifications::DuplicateFoundAdminNotification.main.notify! duplicatable
  end
end
