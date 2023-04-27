class TwilioLogAttachment < ApplicationRecord
  belongs_to :twilio_log, optional: true

  has_one_attached :attachment

  validates :attachment,
            presence: true,
            content_type: { in: RadCommon::VALID_IMAGE_TYPES, message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }
end
