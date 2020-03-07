class NotificationSetting < ApplicationRecord
  belongs_to :notification_type
  belongs_to :user

  scope :enabled, -> { where(enabled: true) }

  validate :validate_notify_methods
  validate :validate_sms_possible_app
  validate :validate_sms_possible_user

  audited associated_with: :user

  def self.settings_for_user(user)
    return [] if user.external?

    types = Pundit.policy_scope!(user, NotificationType).by_type
    settings = []

    types.each do |notification_type|
      settings.push NotificationSetting.find_or_initialize_by(notification_type: notification_type,
                                                              user_id: user.id)
    end

    settings
  end

  private

    def validate_notify_methods
      return unless enabled?

      errors.add(:enabled, 'requires one of email/sms/feed be turned on') if !email? && !sms? && !feed?
      return if notification_type.blank?

      if !notification_type.email_enabled? && email?
        errors.add(:email, 'is not enabled for this notification type')
      end

      if !notification_type.sms_enabled? && sms?
        errors.add(:sms, 'is not enabled for this notification type')
      end

      if !notification_type.feed_enabled? && feed?
        errors.add(:feed, 'is not enabled for this notification type')
      end
    end

    def validate_sms_possible_app
      return if RadicalTwilio.twilio_enabled? || !sms?

      errors.add(:sms, 'is not available for this application')
    end

    def validate_sms_possible_user
      return if user.blank?
      return unless sms? && user.mobile_phone.blank?

      errors.add(:sms, 'is not available unless mobile phone is entered')
    end
end
