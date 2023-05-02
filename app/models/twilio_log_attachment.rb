class TwilioLogAttachment < ApplicationRecord
  belongs_to :twilio_log, optional: true

  has_one_attached :attachment

  # TODO: adding gifs to valid image types see https://swell.radicalbear.com/tasks/41824
  validates :attachment,
            presence: true,
            content_type: { in: RadCommon::VALID_IMAGE_TYPES + %w[image/gif], message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }
end
