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

  scope :sorted, lambda {
    joins(:contact_log).order('contact_logs.created_at DESC, contact_logs.id DESC, contact_log_recipients.id')
  }

  scope :sms_assumed_failed, lambda {
    joins(:contact_log)
      .where(sms_status: :sent, contact_logs: { sms_log_type: :outgoing, service_type: :sms, sent: true })
      .where(created_at: ..1.minute.ago)
      .order(:id)
  }

  ContactLog.service_types.each_key do |service_type|
    scope service_type, -> { joins(:contact_log).where(contact_logs: { service_type: service_type }) }
  end

  ContactLog.sms_log_types.each_key do |sms_log_type|
    scope sms_log_type, -> { joins(:contact_log).where(contact_logs: { sms_log_type: sms_log_type }) }
  end

  validates_with PhoneNumberValidator, fields: [{ field: :phone_number }], skip_twilio: true
  validates_with EmailAddressValidator, fields: [:email], skip_sendgrid: true

  validates :sms_status, presence: true, if: -> { contact_log&.sms? && contact_log&.outgoing? }
  validates :email_status, presence: true, if: -> { contact_log&.email? }
  validates :sms_status, absence: true, if: -> { contact_log&.email? || contact_log&.incoming? }
  validates :email_status, :sendgrid_reason, absence: true, if: -> { contact_log&.sms? }

  validate :validate_service_type
  validate :validate_incoming_fields

  before_validation :check_success
  after_commit :maybe_notify, only: :update

  audited
  strip_attributes

  def active?
    success?
  end

  def sms_assume_failed!
    update! sms_status: :failed
    return unless notify_on_fail?

    Notifications::OutgoingContactFailedNotification.main(self).notify!
  end

  private

    def check_success
      return if contact_log.blank?

      if contact_log.incoming?
        self.success = true
      elsif contact_log.sms?
        self.success = sms_status_delivered?
      elsif contact_log.email?
        self.success = email_status_delivered?
      end
    end

    def validate_incoming_fields
      return if contact_log.blank? || contact_log.outgoing? || contact_log.email?

      errors.add(:to_user_id, 'must be blank') if to_user_id.present?
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

    def maybe_notify
      return unless notify_on_fail? && success_previously_changed?(from: true, to: false)

      Notifications::OutgoingContactFailedNotification.main(self).notify!
    end
end
