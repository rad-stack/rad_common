class NotificationType < ApplicationRecord
  has_many :notification_security_roles, dependent: :destroy
  has_many :security_roles, through: :notification_security_roles, dependent: :destroy
  has_many :notification_settings, dependent: :destroy

  attr_accessor :payload
  alias_attribute :to_s, :description

  scope :by_type, -> { order(:type) }

  validate :validate_auth, on: :update

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

  def mailer_options
    {}
  end

  def exclude_user_ids
    []
  end

  def feed_record
    payload
  end

  def feed_content
    description
  end

  def sms_content
    feed_content
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
      where_clause = 'users.id IN (SELECT user_id FROM security_roles_users WHERE security_role_id IN '\
                     '(SELECT security_role_id FROM notification_security_roles WHERE notification_type_id = ?))'

      users = users.where(where_clause, id)
    end

    users
  end

  def self.seed_items
    Notifications::NewUserSignedUpNotification.create!
    Notifications::UserWasApprovedNotification.create!
    Notifications::UserAcceptsInvitationNotification.create!
    Notifications::GlobalValidityNotification.create!
  end

  def self.main
    NotificationType.find_or_create_by!(type: name)
  end

  def notify!(payload)
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
      errors.add(:base, 'invalid with security roles') if absolute_user? && security_roles.count.positive?
      errors.add(:base, 'invalid without security roles') if security_roles? && security_roles.count.zero?
    end

    def notify_email!
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
      all_ids = notify_user_ids_all
      return if all_ids.count.zero?

      opted_ids = notify_user_ids_opted(:feed)

      all_ids.each do |user_id|
        Notification.create! user_id: user_id,
                             notification_type: self,
                             content: feed_content,
                             record: feed_record,
                             unread: opted_ids.include?(user_id)
      end
    end

    def notify_sms!
      return unless RadicalTwilio.twilio_enabled?

      id_list = notify_user_ids_opted(:sms)
      return if id_list.count.zero?

      SystemSmsJob.perform_later "Message from #{I18n.t(:app_name)}: #{sms_content}", id_list, nil
    end

    def notify_user_ids_all
      if security_roles? && notification_security_roles.count.zero?
        notification_security_roles.create! security_role: SecurityRole.admin_role
      end

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

      raise 'no users to notify' if security_roles? && user_ids.count.zero?

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
