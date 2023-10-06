module Notifications
  class DuplicateFoundAdminNotification < DuplicateFoundNotification
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
  end
end
