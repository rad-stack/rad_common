module Notifications
  class OutgoingContactFailedNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      ids = []
      ids += [from_user.id] if from_user.present?

      records = SecurityRole.admin_role.users.active
      records = records.where.not(id: to_user.id) if to_user.present?
      raise 'no users to notify' if records.blank?

      ids + records.pluck(:id)
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
      contact_log
    end

    private

      def feed_content_item
        to_user.presence || email.presence || phone_number.presence
      end

      def contact_description
        RadEnum.new(ContactLog, 'service_type').translation(contact_log.service_type)
      end

      def contact_log
        payload.contact_log
      end

      def from_user
        contact_log.from_user
      end

      def to_user
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
