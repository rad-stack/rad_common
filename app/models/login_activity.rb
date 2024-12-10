class LoginActivity < ApplicationRecord
  belongs_to :user, polymorphic: true, optional: true

  scope :recent_first, -> { order(id: :desc) }
  scope :successful, -> { where(success: true) }
  scope :failure, -> { where(success: false) }

  strip_attributes
end
