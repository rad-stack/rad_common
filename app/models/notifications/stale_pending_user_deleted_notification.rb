module Notifications
  class StalePendingUserDeletedNotification < ::NotificationType
    def mailer_message
      days = RadUser::STALE_PENDING_DAYS

      message = "#{payload[:name]} was deleted because they were pending for more than #{days} days."
      message += "\n\n\u2022 Email: #{payload[:email]}"
      message += "\n\n\u2022 Mobile Phone: #{payload[:mobile_phone] || 'N/A'}"
      message += "\n\n\u2022 Created: #{ApplicationController.helpers.format_date(payload[:created_at])}"

      message
    end

    def subject_record
      nil
    end
  end
end
