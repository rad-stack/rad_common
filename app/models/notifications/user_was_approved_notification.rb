module Notifications
  class UserWasApprovedNotification < ::NotificationType
    def self.notify_email!(subject)
      RadbearMailer.user_was_approved(notify_user_ids(subject, :email),
                                      approvee(subject),
                                      approver(subject)).deliver_later
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

        def exclude_user_ids(subject)
          [approvee(subject).id]
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
