class NotificationType < ApplicationRecord
  has_many :notification_security_roles, dependent: :destroy
  has_many :security_roles, through: :notification_security_roles, dependent: :destroy
  has_many :notification_settings, dependent: :destroy

  attr_accessor :payload

  alias_attribute :to_s, :description

  scope :by_type, -> { order(:type) }

  validate :validate_auth

  def email_enabled?
    true
  end

  def sms_enabled?
    true
  end

  def feed_enabled?
    true
  end

  def mailer_class
    'RadMailer'
  end

  def mailer_method
    'simple_message'
  end

  def mailer_subject
    description
  end

  def mailer_message
    return description if subject_record.blank?

    "#{description}: #{subject_record}"
  end

  def mailer_options
    return {} if subject_url.blank?

    { email_action: { message: 'Click here to view the details.',
                      button_text: 'View',
                      button_url: subject_url } }
  end

  def exclude_user_ids
    []
  end

  def subject_record
    payload
  end

  def feed_content
    description
  end

  def sms_content
    "#{description}: #{subject_url}"
  end

  def subject_url
    return if subject_record.blank? || !ApplicationController.helpers.show_route_exists_for?(subject_record)

    Rails.application.routes.url_helpers.url_for(subject_record)
  end

  def auth_mode
    :security_roles
  end

  def description
    type.gsub('Notifications::', '').underscore.titleize.gsub(' Notification', '')
  end

  def permitted_users
    users = User.active

    if security_roles?
      where_clause = 'users.id IN (SELECT user_id FROM user_security_roles WHERE security_role_id IN ' \
                     '(SELECT security_role_id FROM notification_security_roles WHERE notification_type_id = ?))'

      users = users.where(where_clause, id)
    end

    users
  end

  def self.main
    NotificationType.find_by!(type: name)
  end

  def notify!(payload)
    return unless active?

    @payload = payload

    notify_email!
    notify_feed!
    notify_sms!
  end

  def auth_mode_name
    security_roles? ? 'Security Roles' : 'Absolute Users'
  end

  def security_roles?
    auth_mode == :security_roles
  end

  def absolute_users?
    auth_mode == :absolute_users
  end

  private

    def validate_auth
      errors.add(:base, 'invalid with security roles') if absolute_users? && security_roles.present?
      errors.add(:base, 'invalid without security roles') if security_roles? && security_roles.blank?
    end

    def notify_email!
      return unless email_enabled?

      id_list = notify_user_ids_opted(:email)
      return if id_list.none?

      if mailer_class == 'RadMailer' && mailer_method == 'simple_message'
        RadMailer.simple_message(id_list,
                                     mailer_subject,
                                     mailer_message,
                                     mailer_options.merge(notification_settings_link: true)).deliver_later
      else
        mailer = mailer_class.constantize

        unless mailer == NotificationMailer || mailer.superclass == NotificationMailer
          raise 'all notification mailers must subclass NotificationMailer'
        end

        mailer.send(mailer_method, id_list, payload).deliver_later
      end
    end

    def notify_feed!
      return unless feed_enabled?

      all_ids = notify_user_ids_all
      return if all_ids.none?

      opted_ids = notify_user_ids_opted(:feed)

      all_ids.each do |user_id|
        Notification.create! user_id: user_id,
                             notification_type: self,
                             content: feed_content,
                             record: subject_record,
                             unread: opted_ids.include?(user_id)
      end
    end

    def notify_sms!
      return unless sms_enabled? && sms_content && RadTwilio.new.twilio_enabled?

      id_list = notify_user_ids_opted(:sms)

      id_list.each do |user_id|
        UserSMSSenderJob.perform_later "Message from #{RadConfig.app_name!}: #{sms_content}",
                                       user_id,
                                       user_id,
                                       nil,
                                       false
      end
    end

    def notify_user_ids_all
      if security_roles?
        users = permitted_users
      else
        users = User.where(id: absolute_user_ids)
        raise 'absolute users must be active' unless users.size == users.active.size
      end

      user_ids = users.where
                      .not(id: NotificationSetting.where(notification_type: self, enabled: false)
                      .pluck(:user_id)).pluck(:id)

      raise 'no users to notify' if security_roles? && user_ids.none?

      return user_ids unless security_roles?
      raise 'exclude_user_ids is invalid' unless exclude_user_ids.is_a?(Array)

      user_ids - exclude_user_ids
    end

    def notify_user_ids_opted(notification_method)
      user_ids = notify_user_ids_all
      user_ids - opt_out_by_notification_method(notification_method, user_ids)
    end

    def opt_out_by_notification_method(notification_method, user_ids)
      opted_out = []

      user_ids.each do |user_id|
        opted_out.push(user_id) unless enabled_for_method?(user_id, notification_method)
      end

      opted_out
    end

    def enabled_for_method?(user_id, notification_method)
      setting = notification_settings.find_by(user_id: user_id)

      if notification_method == :email
        return true if setting.blank?

        setting.enabled? && setting.email?
      elsif setting.blank? || !setting.enabled
        false
      else
        setting.send(notification_method)
      end
    end
end
