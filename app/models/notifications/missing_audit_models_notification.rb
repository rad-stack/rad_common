module Notifications
  class MissingAuditModelsNotification < ::NotificationType
    def mailer_message
      "The following models from audits are missing: #{payload.join(', ')}"
    end

    def subject_record
      nil
    end
  end
end
