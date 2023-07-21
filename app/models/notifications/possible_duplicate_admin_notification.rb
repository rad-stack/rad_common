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
        subject_record.audits.where(action: 'create').first&.user
      end
  end
end
