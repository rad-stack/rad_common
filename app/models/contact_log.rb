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

  validates :from_user_id, presence: true, if: -> { outgoing? && sms? }
  validates :sms_message_id, presence: true, if: :incoming?
  validates :content, presence: true, if: :sent?
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

  def card_style
    items = contact_log_recipients.pluck(:success).uniq
    return 'bg-warning bg-opacity-25' if items.size == 2
    return 'bg-danger bg-opacity-25' if items.blank? || (items.size == 1 && !items.first)
    return if items.size == 1 && items.first

    raise 'we missed something here'
  end

  def table_row_style
    return if card_style.blank?

    card_style.gsub('bg-warning', 'table-warning').gsub('bg-danger', 'table-danger')
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

  private

    def validate_incoming
      errors.add(:sent, 'must be true') unless sent?
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end

    def validate_sms_only_booleans
      errors.add(:sms_opt_out_message_sent, 'must be false') if sms_opt_out_message_sent?
    end
end
