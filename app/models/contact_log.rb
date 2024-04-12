class ContactLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User', optional: true
  belongs_to :to_user, class_name: 'User', optional: true

  has_many :twilio_log_attachments, dependent: :destroy

  enum log_type: { outgoing: 0, incoming: 1 }

  enum twilio_status: { accepted: 0,
                        scheduled: 1,
                        queued: 2,
                        sending: 3,
                        sent: 4,
                        receiving: 5,
                        delivered: 6,
                        undelivered: 7,
                        failed: 8 }, _prefix: true

  alias_attribute :active?, :success?

  scope :last_day, -> { where('created_at > ?', 24.hours.ago) }
  scope :failure, -> { where(success: false) }
  scope :successful, -> { where(success: true) }

  validates :from_user_id, presence: true, if: :outgoing?
  validates :message_sid, presence: true, if: :incoming?
  validates :to_user_id, :media_url, :twilio_status, absence: true, if: :incoming?
  validate :validate_incoming, if: :incoming?

  validates_with PhoneNumberValidator, fields: [{ field: :from_number }, { field: :to_number }], skip_twilio: true

  before_validation :check_success

  def self.opt_out_message_sent?(to_number)
    ContactLog.where(sent: true, opt_out_message_sent: true, to_number: to_number).limit(1).any?
  end

  def status
    return 'not sent' unless sent?
    return if twilio_status.blank?

    RadEnum.new(ContactLog, :twilio_status).translated_option(self)
  end

  private

    def check_success
      return unless twilio_status_delivered?

      self.success = true
    end

    def validate_incoming
      errors.add(:sent, 'must be true') unless sent?
      errors.add(:success, 'must be true') unless success?
      errors.add(:opt_out_message_sent, 'must be false') if opt_out_message_sent?
    end
end
