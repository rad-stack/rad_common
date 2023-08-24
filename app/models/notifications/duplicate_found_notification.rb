module Notifications
  class DuplicateFoundNotification < ::NotificationType
    private

      def created_by_user
        user = subject_record.audits.where(action: 'create').first&.user
        user = subject_record if user.blank? && subject_record.is_a?(User)
        return user if user

        raise 'no created by user found'
      end
  end
end
