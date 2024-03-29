module Notifications
  class UserWasApprovedNotification < ::NotificationType
    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'user_was_approved'
    end

    def feed_content
      "#{approvee} was approved by #{approved_by_name}."
    end

    def subject_record
      approvee
    end

    def sms_content
      "#{feed_content} #{subject_url}"
    end

    def approvee
      payload.first
    end

    def approver
      payload.last
    end

    def approved_by_name
      (approver ? approver.to_s : 'an admin')
    end

    def exclude_user_ids
      [approvee.id]
    end
  end
end
