class UserStatus < ApplicationRecord
  PENDING_STATUS_NAME = 'Pending'.freeze
  ACTIVE_STATUS_NAME = 'Active'.freeze
  INACTIVE_STATUS_NAME = 'Inactive'.freeze

  PENDING_STATUS_ERROR = 'pending user status not allowed'.freeze

  scope :not_pending, -> { where.not(id: default_pending_status.id) }
  scope :by_id, -> { order(:id) }

  alias_attribute :to_s, :name

  validate :validate_pending

  strip_attributes

  def self.default_pending_status
    raise PENDING_STATUS_ERROR unless RadConfig.pending_users?

    UserStatus.find_by(name: PENDING_STATUS_NAME)
  end

  def self.default_active_status
    UserStatus.find_by(name: ACTIVE_STATUS_NAME)
  end

  def self.default_inactive_status
    UserStatus.find_by(name: INACTIVE_STATUS_NAME)
  end

  private

    def validate_pending
      return unless !RadConfig.pending_users? && name == PENDING_STATUS_NAME

      raise PENDING_STATUS_ERROR
    end
end
