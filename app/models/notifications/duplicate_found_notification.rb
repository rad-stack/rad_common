module Notifications
  class DuplicateFoundNotification < ::NotificationType
    private

      def created_by
        user = subject_record.created_by
        user = subject_record if user.blank? && subject_record.is_a?(User)
        return user if user

        raise 'no created by user found'
      end
  end
end
