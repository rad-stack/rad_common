module Notifications
  class StalePendingUserDeletedNotification < ::NotificationType
    def mailer_message
      "#{payload[:name]} was deleted because they were pending for more than #{RadUser::STALE_PENDING_DAYS} days." \
        " Email: #{payload[:email]}, Mobile Phone: #{payload[:mobile_phone] || 'N/A'}," \
        " Created: #{ApplicationController.helpers.format_date(payload[:created_at])}"
    end

    def subject_record
      nil
    end
  end
end
