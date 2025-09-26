module Notifications
  class OutgoingContactFailedNotification < ::NotificationType
    def auth_mode
      :absolute_users
    end

    def absolute_user_ids
      ids = maybe_add_from_user
      log = "ids : #{ids}\n"
      log += "contact_log.sms? #{contact_log.sms?} \n"
      if contact_log.sms?
        ids.push(to_user.id) if to_user.present? && to_user.internal?
      else
        ids.delete(to_user.id) if to_user.present?
        ids = SecurityRole.admin_role.users.active.pluck(:id) if ids.blank?
        ids.delete(to_user.id) if to_user.present?
      end

      User.all.each do |user|
        log += "User: #{user.to_s} Security Roles #{user.security_roles.map(&:to_s).join(', ')}#{user}\n"
      end
      raise "no users to notify current_users: #{log}" if ids.blank?

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
      return contact_log if can_show?(contact_log)
      return contact_log.record if contact_log.record.present? && can_show?(contact_log.record)

      raise "missing subject for #{contact_log.id} - see Task 5211"
    end

    def sms_enabled?
      false
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

      def can_show?(record)
        notify_user_ids_all.each do |user_id|
          return true if Pundit.policy!(User.find(user_id), record).show?
        end

        false
      end

      def maybe_add_from_user
        return [] if from_user.blank?
        return [] if contact_log.sms? && to_user.present? && to_user.internal?

        [from_user.id]
      end
  end
end
