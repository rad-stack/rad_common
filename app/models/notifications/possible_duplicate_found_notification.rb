module Notifications
  class PossibleDuplicateFoundNotification < ::NotificationType
    def absolute_user_ids
      [created_by_user.id]
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
        user = subject_record.audits.where(action: 'create').first&.user
        return user if user

        raise 'no created by user found'
      end
  end
end
