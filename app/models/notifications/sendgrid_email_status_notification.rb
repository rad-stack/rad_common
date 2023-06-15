module Notifications
  class SendgridEmailStatusNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      records = SecurityRole.admin_role.users.active
      records = records.where.not(id: user.id) if user.present?
      raise 'no users to notify' if records.blank?

      records.pluck(:id)
    end

    def mailer_class
      'NotificationMailer'
    end

    def mailer_method
      'sendgrid_status'
    end

    def feed_content
      "SendGrid Email Status for #{feed_content_item}"
    end

    def subject_record
      user
    end

    private

      def feed_content_item
        user.presence || email
      end

      def user
        User.find_by(email: email)
      end

      def email
        payload[:email]
      end
  end
end
