module Notifications
  class UserWasApprovedNotification < ::NotificationType
    class << self
      protected

        def mailer_class
          'RadbearMailer'
        end

        def mailer_method
          'user_was_approved'
        end

        def feed_content(payload)
          "#{approvee(payload)} was approved by #{approved_by_name(payload)}."
        end

        def feed_record(payload)
          approvee(payload)
        end

        def sms_content(payload)
          feed_content(payload)
        end

        def exclude_user_ids(payload)
          [approvee(payload).id]
        end

        def approvee(payload)
          payload.first
        end

        def approver(payload)
          payload.last
        end

        def approved_by_name(payload)
          (approver(payload) ? approver(payload).to_s : 'an admin')
        end
    end
  end
end
