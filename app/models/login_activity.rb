class LoginActivity < ApplicationRecord
  belongs_to :user, polymorphic: true, optional: true
  scope :recent_first, -> { order(id: :desc) }
end
