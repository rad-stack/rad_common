module Notifications
  class PaceErrorNotification < ::NotificationType
    def mailer_message
      "#{subject_record.error_message} : Please update mappings"
    end

    def sms_enabled?
      false
    end

    def feed_enabled?
      false
    end

    def subject_record
      payload[:import_record]
    end

    def object_type
      return if payload.blank?

      payload[:object_type]
    end

    def subject_url
      '/'
    end
  end
end
