module Notifications
  class UserWasApprovedNotification < ::NotificationType
    def self.notify_email!(subject)
      # TODO: don't send unless user wants emails
      RadbearMailer.user_was_approved(recipient_user_ids(subject), approvee(subject), approver(subject)).deliver_later
    end

    class << self
      private

        def feed_content(subject)
          # TODO: add link
          "#{approvee(subject)} was approved by #{approved_by_name(subject)}."
        end

        def sms_content(subject)
          feed_content(subject)
        end

        def recipient_user_ids(subject)
          users_except_self(subject)
        end

        def users_except_self(subject)
          notify_user_ids - [approvee(subject).id]
        end

        def approvee(subject)
          subject.first
        end

        def approver(subject)
          subject.last
        end

        def approved_by_name(subject)
          (approver(subject) ? approver(subject).to_s : 'an admin')
        end
    end
  end
end
