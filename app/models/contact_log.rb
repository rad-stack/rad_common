class ContactLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User', optional: true
  belongs_to :record, polymorphic: true, optional: true

  has_many :contact_log_recipients, dependent: :destroy

  enum log_type: { outgoing: 0, incoming: 1 }
  enum service_type: { twilio: 0, sendgrid: 1 }

  alias_attribute :active?, :success?

  scope :sorted, -> { order(created_at: :desc, id: :desc) }

  validates :from_user_id, presence: true, if: -> { outgoing? && twilio? }
  validates :message_sid, presence: true, if: :incoming?
  validates :media_url, absence: true, if: :incoming?
  validate :validate_incoming, if: :incoming?

  validates_with PhoneNumberValidator, fields: [{ field: :from_number }], skip_twilio: true

  def self.opt_out_message_sent?(to_number)
    ContactLog.twilio.joins(:contact_log_recipients)
              .exists?(sent: true, opt_out_message_sent: true, contact_log_recipients: { phone_number: to_number })
  end

  private

    def validate_incoming
      errors.add(:sent, 'must be true') unless sent?
      errors.add(:opt_out_message_sent, 'must be false') if opt_out_message_sent?
    end
end
