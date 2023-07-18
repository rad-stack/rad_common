module Notifications
  class PossibleDuplicateFoundNotification < ::NotificationType
    def absolute_user_ids
      created_by_user = subject_record.audits.order(created_at: :desc).first&.user
      return [created_by_user.id] if created_by_user.present?

      []
    end

    def subject_record
      nil
    end
  end
end
