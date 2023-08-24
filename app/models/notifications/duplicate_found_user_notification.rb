module Notifications
  class DuplicateFoundUserNotification < DuplicateFoundNotification
    def mailer_subject
      "Possible Duplicate (#{subject_record}) Entered By You"
    end

    def mailer_message
      "The system detected that you entered a possible duplicate (#{subject_record}). " \
        'Please review the record and ensure that it is indeed a new record.'
    end

    def absolute_user_ids
      [created_by_user.id]
    end

    def auth_mode
      :absolute_users
    end
  end
end
