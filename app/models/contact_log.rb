class ContactLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User', optional: true
  belongs_to :record, polymorphic: true, optional: true

  has_many :contact_log_recipients, dependent: :destroy

  enum :direction, { outgoing: 0, incoming: 1 }
  enum :service_type, { sms: 0, email: 1, voice: 2, fax: 3 }

  scope :sorted, -> { order(created_at: :desc, id: :desc) }
  scope :failed, -> { where(contact_log_recipients: { success: false }) }
  scope :successful, -> { where(contact_log_recipients: { success: true }) }

  scope :associated_with_user, lambda { |user_id|
    query = "(record_type = 'User' AND record_id = #{user_id}) OR " \
            "from_user_id = #{user_id} OR " \
            "contact_log_recipients.to_user_id = #{user_id}"

    joins(:contact_log_recipients).where(query).distinct
  }

  # TODO: this was added for IJS but need to finish the feature for general use - Task 8671
  has_many_attached :attachments

  validates :from_user_id, presence: true, if: -> { outgoing? && (sms? || fax?) }
  validates :sms_message_id, presence: true, if: -> { incoming? && sms? }
  validates :fax_message_id, :record_type, :record_id, presence: true, if: -> { fax? && sent? }
  validates :content, presence: true, if: -> { sent? && !fax? }
  validates :content, absence: true, if: :fax?
  validates :direction, presence: true, if: -> { sms? || fax? }
  validates :direction, :sms_media_url, :sms_message_id, absence: true, if: :email?
  validates :fax_message_id, absence: true, unless: -> { fax? }
  validate :validate_incoming, if: :incoming?
  validate :validate_attachments_exists, if: :fax?
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

  def card_style
    items = contact_log_recipients.pluck(:success).uniq

    return 'bg-warning bg-opacity-25' if items.size == 2
    return 'bg-danger bg-opacity-25' if items.blank? || (items.size == 1 && !items.first)
    return if items.size == 1 && items.first

    raise 'we missed something here'
  end

  def table_row_style
    return if card_style.blank?

    card_style.gsub('bg-warning bg-opacity-25', 'table-warning').gsub('bg-danger bg-opacity-25', 'table-danger')
  end

  def from_user_is_to_user?
    return false if from_user.blank?

    enum_value = RadEnum.new(ContactLogRecipient, 'email_type').db_value(:to)

    contact_log_recipients.where('email_type IS NULL OR email_type = ?', enum_value)
                          .pluck(:to_user_id)
                          .include?(from_user_id)
  end

  def record_is_to_user?
    return false unless record.present? && record.is_a?(User)

    contact_log_recipients.pluck(:to_user_id).include?(record_id)
  end

  def self.create_fax_log_and_send!(to_number:, attachments:, from_user_id:, associated_record:)
    log = create_fax_log!(to_number: to_number, attachments: attachments, from_user_id: from_user_id,
                          associated_record: associated_record)
    FaxSenderJob.perform_later(log)
  end

  def self.create_fax_log!(to_number:, attachments:, associated_record:, from_user_id:, to_user: nil)
    log = ContactLog.new service_type: :fax,
                         direction: :outgoing,
                         from_number: SinchFaxClient.from_number,
                         from_user_id: from_user_id,
                         sent: false,
                         record: associated_record

    attachments.each do |attachment|
      log.attachments.attach(
        io: StringIO.new(attachment),
        filename: "fax_#{Time.current.to_i}.pdf",
        content_type: 'application/pdf'
      )
    end
    log.save!

    ContactLogRecipient.create! contact_log: log,
                                phone_number: to_number,
                                to_user: to_user,
                                fax_status: :in_progress

    log
  end

  private

    def validate_incoming
      errors.add(:sent, 'must be true') unless sent?
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end

    def validate_sms_only_booleans
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end

    def validate_attachments_exists
      errors.add(:attachments, 'must have at least one attachment') if attachments.blank?
    end
end
