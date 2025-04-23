module Notifications
  class AuditTypeMismatchNotification < ::NotificationType
    def mailer_message
      "AuditTypeMismatch: Invalid types found in audits - #{payload.join(', ')}"
    end

    def subject_record
      nil
    end
  end
end
