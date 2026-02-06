module Notifications
  class MissingRecordInPaceNotification < PaceErrorNotification
    def mailer_subject
      "Missing #{object_type} in Pace"
    end
  end
end
