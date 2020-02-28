module Notifications
  class NewUserSignedUpNotification < ::NotificationType
    class << self
      protected

        def notify_email!(subject)
          RadbearMailer.new_user_signed_up(notify_user_ids(subject, :email), subject).deliver_later
        end

        def feed_content(subject)
          # TODO: add link
          "#{subject} signed up."
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
