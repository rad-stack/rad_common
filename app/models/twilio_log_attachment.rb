class TwilioLogAttachment < ApplicationRecord
  belongs_to :twilio_log, optional: true

  VALID_IMAGE_TYPES = (RadCommon::VALID_IMAGE_TYPES + %w[image/gif]).freeze

  scope :images, lambda {
    joins(attachment_attachment: { blob: :attachments })
      .where(active_storage_blobs: { content_type: VALID_IMAGE_TYPES })
  }
  scope :other_files, lambda {
    joins(attachment_attachment: { blob: :attachments })
      .where.not(active_storage_blobs: { content_type: VALID_IMAGE_TYPES })
  }

  has_one_attached :attachment

  # TODO: adding gifs to valid image types see https://swell.radicalbear.com/tasks/41824
  validates :attachment,
            presence: true,
            content_type: { in: RadCommon::VALID_ATTACHMENT_TYPES,
                            message: RadCommon::VALID_CONTENT_TYPE_MESSAGE }
end
