module Notifications
  class GlobalValidityNotification < ::NotificationType
    def self.notify_email!(subject)
      RadbearMailer.global_validity(notify_user_ids(subject, :email), subject).deliver_later
    end

    class << self
      private

        def feed_content(_subject)
          'Invalid data was found in the system.'
        end

        def sms_content(subject)
          feed_content(subject)
        end

        def exclude_user_ids(_subject)
          []
        end
    end
  end
end
