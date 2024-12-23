module Notifications
  class DuplicateFoundAdminNotification < ::NotificationType
    def mailer_subject
      return "Possible Duplicate User (#{subject_record}) Signed Up" if user_signing_up?

      "Possible Duplicate (#{subject_record}) Entered By #{created_by.presence || 'a System Process'}"
    end

    def mailer_message
      if user_signing_up?
        return "The system detected that #{subject_record} signed up and is possibly already in the system as a " \
               'user. Please review the record and ensure that it is indeed a new record.'
      end

      "The system detected that #{created_by.presence || 'a system process'} entered a possible " \
        "duplicate (#{subject_record}). Please review the record and ensure that it is indeed a new record."
    end

    def mailer_contact_log_from_user
      created_by
    end

    def subject_url
      Rails.application.routes.url_helpers.resolve_duplicates_url model: subject_record.class, id: subject_record.id
    end

    private

      def created_by
        user = subject_record.created_by
        user = subject_record if user.blank? && subject_record.is_a?(User)
        user = subject_record.modified_by if user.blank?
        user
      end

      def user_signing_up?
        subject_record.is_a?(User) && subject_record == created_by
      end
  end
end
