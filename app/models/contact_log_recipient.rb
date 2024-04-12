class ContactLogRecipient < ApplicationRecord
  belongs_to :contact_log
  belongs_to :to_user, class_name: 'User', optional: true

  enum email_type: { to: 0, cc: 1, bcc: 2 }
  # TODO: Determine twilio and sendgrid status differences
  enum service_status: { accepted: 0,
                         scheduled: 1,
                         queued: 2,
                         sending: 3,
                         sent: 4,
                         receiving: 5,
                         delivered: 6,
                         undelivered: 7,
                         failed: 8 }, _prefix: true

  scope :failure, -> { where(success: false) }
  scope :successful, -> { where(success: true) }
  scope :last_day, -> { joins(:contact_log).where('contact_logs.created_at > ?', 24.hours.ago) }
  ContactLog.service_types.each_key do |service_type|
    scope service_type, -> { joins(:contact_log).where(contact_logs: { service_type: service_type }) }
  end
  ContactLog.log_types.each_key do |log_type|
    scope log_type, -> { joins(:contact_log).where(contact_logs: { log_type: log_type }) }
  end

  validates_with PhoneNumberValidator, fields: [{ field: :phone_number }], skip_twilio: true
  validates_with EmailAddressValidator, fields: [:email], skip_sendgrid: true

  validate :validate_service_type
  validate :validate_incoming_fields

  before_validation :check_success

  # TODO: Verify that this is method is actually used
  def status
    return 'not sent' unless contact_log.sent?
    return if service_status.blank?

    RadEnum.new(self.class, :service_status).translated_option(self)
  end

  private

    def check_success
      return unless service_status_delivered?

      self.success = true
    end

    def validate_incoming_fields
      return if contact_log.blank? || contact_log.outgoing?

      errors.add(:to_user_id, 'must be blank') if to_user_id.present?
      errors.add(:service_status, 'must be blank') if service_status.present?
      errors.add(:success, 'must be true') unless success?
    end

    def validate_service_type
      return if contact_log.blank?

      if contact_log.twilio?
        errors.add(:email, 'must be blank') if email.present?
        errors.add(:phone_number, 'must be present') if phone_number.blank?
      else
        errors.add(:phone_number, 'must be blank') if phone_number.present?
        errors.add(:email, 'must be present') if email.blank?
      end
    end
end
