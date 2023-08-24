module Notifications
  class DuplicateFoundAdminNotification < DuplicateFoundNotification
    def mailer_subject
      "Possible Duplicate (#{subject_record}) Entered By #{created_by_user}"
    end

    def mailer_message
      "The system detected that #{created_by_user} entered a possible duplicate (#{subject_record}). " \
        'Please review the record and ensure that it is indeed a new record.'
    end
  end
end
