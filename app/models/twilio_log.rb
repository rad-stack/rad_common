class ContactLog < ApplicationRecord
  belongs_to :from_user, class_name: 'User', optional: true
  belongs_to :to_user, class_name: 'User', optional: true

  scope :from_system, -> { where(from_user_id: nil) }
  scope :outgoing, -> { where(from_number: RadConfig.twilio_phone_number!) }
  scope :incoming, -> { where(to_number: RadConfig.twilio_phone_number!) }

  has_many_attached :attachments

  def self.opt_out_message_sent?(to_number)
    ContactLog.where(success: true, opt_out_message_sent: true, to_number: to_number).limit(1).any?
  end

  def media_url_image?
    return false if media_url.blank?

    RadCommon::VALID_IMAGE_TYPES.map { |type| type.delete_prefix('image/') }
                                .any? { |type| media_url.ends_with?(type) }
  end
end
