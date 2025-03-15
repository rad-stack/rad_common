module Notifications
  class DuplicateFoundUserNotification < ::NotificationType
    def mailer_subject
      "Possible Duplicate (#{subject_record}) Entered By You"
    end

    def mailer_message
      "The system detected that you entered a possible duplicate (#{subject_record}). " \
        'Please review the record and ensure that it is indeed a new record.'
    end

    def mailer_contact_log_from_user
      created_by
    end

    def absolute_user_ids
      [created_by.id]
    end

    def auth_mode
      :absolute_users
    end

    def should_send?(admin_notification)
      return false unless active_internal_user?

      admin_notification.notify_user_ids_all.exclude?(created_by.id)
    end

    private

      def created_by
        subject_record.created_by
      end

      def active_internal_user?
        created_by.present? && created_by.active? && created_by.internal?
      end
  end
end
