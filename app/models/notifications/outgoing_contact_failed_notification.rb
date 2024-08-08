module Notifications
  class OutgoingContactFailedNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      ids = if from_user.present?
              [from_user.id]
            else
              []
            end

      ids.delete(to_user.id) if to_user.present?
      ids = SecurityRole.admin_role.users.active.pluck(:id) if ids.blank?
      raise 'no users to notify' if ids.blank?

      ids.uniq
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
