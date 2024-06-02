class ContactLogRecipient < ApplicationRecord
  belongs_to :contact_log
  belongs_to :to_user, class_name: 'User', optional: true

  enum email_type: { to: 0, cc: 1, bcc: 2 }

  enum sms_status: { accepted: 0,
                     scheduled: 1,
                     queued: 2,
                     sending: 3,
                     sent: 4,
                     receiving: 5,
                     delivered: 6,
                     undelivered: 7,
                     failed: 8 }, _prefix: true

  enum email_status: { delivered: 0, dropped: 1, bounce: 2, spamreport: 3 }, _prefix: true

  scope :sms, -> { joins(:contact_log).where(contact_logs: { service_type: :sms }) }
  scope :failed, -> { joins(:contact_log).where(success: false) }
  scope :successful, -> { joins(:contact_log).where(success: true) }
  scope :last_day, -> { joins(:contact_log).where('contact_logs.created_at > ?', 24.hours.ago) }
  scope :sorted, -> { order(:id) }

  ContactLog.service_types.each_key do |service_type|
    scope service_type, -> { joins(:contact_log).where(contact_logs: { service_type: service_type }) }
  end

  ContactLog.sms_log_types.each_key do |log_type|
    scope log_type, -> { joins(:contact_log).where(contact_logs: { log_type: log_type }) }
  end

  validates_with PhoneNumberValidator, fields: [{ field: :phone_number }], skip_twilio: true
  validates_with EmailAddressValidator, fields: [:email], skip_sendgrid: true
  validates :sms_status, absence: true, if: -> { contact_log&.email? }
  validates :email_status, absence: true, if: -> { contact_log&.sms? }

  # TODO: should sms_status be required if sms? and email_status be required for email?

  validate :validate_service_type
  validate :validate_incoming_fields

  before_validation :check_success

  audited
  strip_attributes

  def active?
    success?
  end

  private

    def check_success
      return if contact_log.blank?

      if contact_log.sms?
        return unless sms_status_delivered?

        self.success = true
      elsif contact_log.email?
        return unless email_status_delivered?

        self.success = true
      end
    end

    def validate_incoming_fields
      return if contact_log.blank? || contact_log.outgoing? || contact_log.email?

      errors.add(:to_user_id, 'must be blank') if to_user_id.present?
      errors.add(:sms_status, 'must be blank') if sms_status.present?
      errors.add(:success, 'must be true') unless success?
    end

    def validate_service_type
      return if contact_log.blank?

      if contact_log.sms?
        errors.add(:email, 'must be blank') if email.present?
        errors.add(:phone_number, 'must be present') if phone_number.blank?
      else
        errors.add(:phone_number, 'must be blank') if phone_number.present?
        errors.add(:email, 'must be present') if email.blank?
      end
    end
end
