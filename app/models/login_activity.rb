class LoginActivity < ApplicationRecord
  belongs_to :user, polymorphic: true, optional: true

  scope :recent_first, -> { order(id: :desc) }
  scope :successful, -> { where(success: true) }
  scope :failed, -> { where(success: false) }

  strip_attributes

  def active?
    success?
  end
end
