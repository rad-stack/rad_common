module Notifications
  class PossibleDuplicateFoundNotification < ::NotificationType
    def absolute_user_ids
      return [created_by_user.id] if created_by_user.present?

      raise 'no created by user found'
    end
  
    def auth_mode
      :absolute_users
    end

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
