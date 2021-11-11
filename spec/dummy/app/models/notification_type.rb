class NotificationType < ApplicationRecord
  has_many :notification_security_roles, dependent: :destroy
  has_many :security_roles, through: :notification_security_roles, dependent: :destroy
  has_many :notification_settings, dependent: :destroy
  has_many :users, through: :notification_settings
  has_many :security_roles_users, through: :security_roles
  has_many :role_users, source: :user, through: :security_roles_users
  has_many :notifications, dependent: :destroy

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
    'RadbearMailer'
  end

  def mailer_method
    'simple_message'
  end

  def mailer_subject
    description
  end

  def lab_id
    @lab_id ||=
      if absolute_user?
        User.find_by(id: absolute_user_id)&.current_lab_id
      elsif subject_record&.respond_to? :lab
        subject_record.lab.id
      elsif subject_record&.respond_to? :lab_id
        subject_record.lab_id
      else
        Lab.default.id
      end
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
    users = security_roles? ? role_users.active : User.active

    # users.joins(:lab_users).where(lab_users: { lab_id: lab_id })
  end

  def self.seed_items
    Notifications::NewUserSignedUpNotification.create! security_roles: [SecurityRole.admin_role]
    Notifications::UserWasApprovedNotification.create! security_roles: [SecurityRole.admin_role]
    Notifications::UserAcceptedInvitationNotification.create! security_roles: [SecurityRole.admin_role]
    Notifications::InvalidDataWasFoundNotification.create! security_roles: [SecurityRole.admin_role]
    Notifications::GlobalValidityRanLongNotification.create! security_roles: [SecurityRole.admin_role]
  end

  def self.main
    NotificationType.find_or_create_by!(type: name)
  end

  def notify!(payload)
    return if suppress_notifications

    @payload = payload

    notify_email!
    notify_feed!
    notify_sms!
  end

  def auth_mode_name
    security_roles? ? 'Security Roles' : 'Absolute User'
  end

  def security_roles?
    auth_mode == :security_roles
  end

  def absolute_user?
    auth_mode == :absolute_user
  end

  private

    def validate_auth
      errors.add(:base, 'invalid with security roles') if absolute_user? && security_roles.present?
      errors.add(:base, 'invalid without security roles') if security_roles? && security_roles.blank?
    end

    def notify_email!
      return unless email_enabled?

      id_list = notify_user_ids_opted(:email)
      return if id_list.count.zero?

      if mailer_class == 'RadbearMailer' && mailer_method == 'simple_message'

        RadbearMailer.simple_message(id_list,
                                     mailer_subject,
                                     mailer_message,
                                     mailer_options).deliver_later

      else
        mailer = mailer_class.constantize
        mailer.send(mailer_method, id_list, payload).deliver_later
      end
    end

    def notify_feed!
      return unless feed_enabled?

      all_ids = notify_user_ids_all
      return if all_ids.count.zero?

      opted_ids = notify_user_ids_opted(:feed)

      all_ids.each do |user_id|
        Notification.create! user_id: user_id,
                             lab_id: lab_id,
                             notification_type: self,
                             content: feed_content,
                             record: subject_record,
                             unread: opted_ids.include?(user_id)
      end
    end

    def notify_sms!
      return unless sms_enabled? && sms_content && RadicalTwilio.twilio_enabled?

      id_list = notify_user_ids_opted(:sms)
      return if id_list.count.zero?

      SystemSMSJob.perform_later "Message from #{I18n.t(:app_name)}: #{sms_content}", id_list, nil
    end

    def notify_user_ids_all
      if security_roles?
        users = permitted_users
      else
        user = User.find(absolute_user_id)
        raise 'absolute user must be active' unless user.active

        users = User.where(id: user.id)
      end

      user_ids = users.where
                      .not(id: NotificationSetting.where(notification_type: self, enabled: false)
                      .pluck(:user_id)).pluck(:id)

      Raven.capture_exception("no users to notify! notification_type: #{self}") if security_roles? && user_ids.count.zero?

      return user_ids unless security_roles?

      Raven.capture_exception("exclude_user_ids is invalid user_ids: #{exclude_user_ids}") unless exclude_user_ids.is_a?(Array)

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
