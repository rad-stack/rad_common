class NotificationSetting < ApplicationRecord
  belongs_to :notification_type
  belongs_to :user

  scope :enabled, -> { where(enabled: true) }
  scope :by_user, -> { joins(:user).merge(User.sorted) }

  validate :validate_notify_methods
  validate :validate_sms_possible_app
  validate :validate_sms_possible_user

  audited associated_with: :user

  def to_s
    "#{user} - #{notification_type}"
  end

  def active?
    enabled?
  end

  def self.settings_for_user(user)
    types = Pundit.policy_scope!(user, NotificationType).sorted
    types.map { |notification_type| NotificationSetting.init_for_user(notification_type, user) }
  end

  def self.init_for_user(notification_type, user)
    record = NotificationSetting.find_or_initialize_by(notification_type: notification_type, user: user)
    record.check_defaults
    record
  end

  def check_defaults
    return if notification_type.blank? || email? || sms? || feed?

    if notification_type.email_enabled?
      self.email = true
      return
    end

    if notification_type.sms_enabled?
      self.sms = true
      return
    end

    if notification_type.feed_enabled?
      self.feed = true
      return
    end

    raise 'notification type has no methods'
  end

  private

    def validate_notify_methods
      return unless enabled?

      errors.add(:enabled, 'requires one of email/sms/feed be turned on') if !email? && !sms? && !feed?
      return if notification_type.blank?

      errors.add(:email, 'is not enabled for this notification type') if !notification_type.email_enabled? && email?
      errors.add(:sms, 'is not enabled for this notification type') if !notification_type.sms_enabled? && sms?
      errors.add(:feed, 'is not enabled for this notification type') if !notification_type.feed_enabled? && feed?
    end

    def validate_sms_possible_app
      return if RadConfig.twilio_enabled? || !sms?

      errors.add(:sms, 'is not available for this application')
    end

    def validate_sms_possible_user
      return if user.blank?
      return unless sms? && user.mobile_phone.blank?

      errors.add(:sms, 'is not available unless mobile phone is entered')
    end
end
