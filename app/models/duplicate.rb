class Duplicate < ApplicationRecord
  belongs_to :duplicatable, polymorphic: true

  def maybe_notify!
    return unless score && score >= duplicatable.class.score_upper_threshold

    admin_notification = Notifications::DuplicateFoundAdminNotification.main(duplicatable)
    user_notification = Notifications::DuplicateFoundUserNotification.main(duplicatable)

    user_notification.notify! if user_notification.should_send?(admin_notification)
    admin_notification.notify!
  end
end
