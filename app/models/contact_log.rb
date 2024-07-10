class ContactLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User', optional: true
  belongs_to :record, polymorphic: true, optional: true

  has_many :contact_log_recipients, dependent: :destroy

  enum sms_log_type: { outgoing: 0, incoming: 1 }
  enum service_type: { sms: 0, email: 1 }

  scope :sorted, -> { order(created_at: :desc, id: :desc) }

  scope :related_to, lambda { |record|
    if record.is_a?(User)
      # TODO: this might not perform well with the sub select
      query = "(record_type = '#{record.class}' AND record_id = #{record.id}) OR " \
              "from_user_id = #{record.id} OR " \
              "id IN (SELECT contact_log_id FROM contact_log_recipients WHERE to_user_id = #{record.id})"

      where(query)
    else
      where(record: record)
    end
  }

  validates :from_user_id, presence: true, if: -> { outgoing? && sms? }
  validates :sms_message_id, presence: true, if: :incoming?
  validates :content, presence: true, if: :sent?
  validates :sms_media_url, absence: true, if: :incoming?
  validates :sms_log_type, presence: true, if: :sms?
  validates :sms_log_type, :sms_media_url, :sms_message_id, absence: true, if: :email?
  validate :validate_incoming, if: :incoming?
  validate :validate_sms_only_booleans, if: :email?

  validates_with PhoneNumberValidator, fields: [{ field: :from_number }], skip_twilio: true

  audited
  strip_attributes

  def to_s
    "#{ApplicationController.helpers.enum_to_translated_option(self, :service_type)} #{id}"
  end

  def self.opt_out_message_sent?(to_number)
    ContactLog.sms.joins(:contact_log_recipients).exists?(
      sent: true,
      sms_opt_out_message_sent: true,
      contact_log_recipients: { phone_number: to_number }
    )
  end

  def active?
    success?
  end

  def success?
    recipients = contact_log_recipients
    return false if recipients.none?

    !recipients.where(success: false).exists?
  end

  private

    def validate_incoming
      errors.add(:sent, 'must be true') unless sent?
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end

    def validate_sms_only_booleans
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end
end
