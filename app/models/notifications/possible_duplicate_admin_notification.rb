module Notifications
  class PossibleDuplicateAdminNotification < ::NotificationType
    def mailer_message
      "Possible duplicate (#{subject_record}) entered by #{created_by_user}"
    end

    def description
      'Possible duplicate found'
    end

    private

      def created_by_user
        user = subject_record.audits.where(action: 'create').first&.user
        return user if user

        raise 'no created by user found'
      end
  end
end
