class ContactLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User', optional: true
  belongs_to :record, polymorphic: true, optional: true

  has_many :contact_log_recipients, dependent: :destroy

  enum sms_log_type: { outgoing: 0, incoming: 1 }
  enum service_type: { sms: 0, email: 1 }

  scope :sorted, -> { order(created_at: :desc, id: :desc) }

  validates :from_user_id, presence: true, if: -> { outgoing? && sms? }
  validates :sms_message_id, presence: true, if: :incoming?
  validates :sms_media_url, absence: true, if: :incoming?
  validates :sms_log_type, presence: true, if: :sms?
  validates :sms_log_type, :sms_media_url, :sms_message_id, absence: true, if: :email?
  validate :validate_incoming, if: :incoming?
  validate :validate_sms_only_booleans, if: :email?

  validates_with PhoneNumberValidator, fields: [{ field: :from_number }], skip_twilio: true

  def to_s
    "#{ApplicationController.helpers.enum_to_translated_option(self, :service_type)} " \
      "sent on #{ApplicationController.helpers.format_datetime(created_at)}"
  end

  def self.opt_out_message_sent?(to_number)
    ContactLog.sms.joins(:contact_log_recipients).exists?(
      sms_sent: true,
      sms_opt_out_message_sent: true,
      contact_log_recipients: { phone_number: to_number }
    )
  end

  private

    def validate_incoming
      errors.add(:sent, 'must be true') unless sms_sent?
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end

    def validate_sms_only_booleans
      errors.add(:sms_sent, 'must be false') if sms_sent?
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end
end
