class UserStatus < ApplicationRecord
  PENDING_STATUS_NAME = 'Pending'.freeze
  ACTIVE_STATUS_NAME = 'Active'.freeze
  INACTIVE_STATUS_NAME = 'Inactive'.freeze

  scope :not_pending, -> { where.not(id: default_pending_status.id) }
  scope :by_id, -> { order(:id) }

  alias_attribute :to_s, :name

  strip_attributes

  def self.default_pending_status
    UserStatus.find_by(name: PENDING_STATUS_NAME)
  end

  def self.default_active_status
    UserStatus.find_by(name: ACTIVE_STATUS_NAME)
  end

  def self.default_inactive_status
    UserStatus.find_by(name: INACTIVE_STATUS_NAME)
  end
end
