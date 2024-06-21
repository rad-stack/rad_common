module Notifications
  class OutgoingContactFailedNotification < ::NotificationType
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
      'outgoing_contact_failed'
    end

    def feed_content
      "Outgoing #{contact_description} Failed for #{feed_content_item}"
    end

    def subject_record
      user
    end

    private

      def feed_content_item
        user.presence || email.presence || phone_number.presence
      end

      def contact_description
        RadEnum.new(ContactLog, 'service_type').translation(payload.contact_log)
      end

      def user
        payload.to_user
      end

      def email
        payload.email
      end

      def phone_number
        payload.phone_number
      end
  end
end
