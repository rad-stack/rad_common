module Notifications
  class DuplicateFoundAdminNotification < ::NotificationType
    def mailer_subject
      "Possible Duplicate (#{subject_record}) Entered By #{created_by}"
    end

    def mailer_message
      "The system detected that #{created_by} entered a possible duplicate (#{subject_record}). " \
        'Please review the record and ensure that it is indeed a new record.'
    end

    def subject_url
      Rails.application.routes.url_helpers.duplicates_url model: subject_record.class, id: subject_record.id
    end

    private

      def created_by
        user = subject_record.created_by
        user = subject_record if user.blank? && subject_record.is_a?(User)
        return user if user.present?

        raise 'no created by user found'
      end
  end
end
