class TwilioLogAttachment < ApplicationRecord
  belongs_to :twilio_log, optional: true

  has_one_attached :attachment

  validates :attachment, presence: true
end
