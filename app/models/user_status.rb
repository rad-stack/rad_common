class UserStatus < ApplicationRecord
  include Authority::Abilities

  scope :not_pending, -> { where.not(id: UserStatus.default_pending_status.id) }
  scope :by_id, -> { order(:id) }

  alias_attribute :to_s, :name

  def self.default_pending_status
    UserStatus.find_by_name('Pending')
  end

  def self.default_active_status
    UserStatus.find_by_name('Active')
  end

  def self.default_inactive_status
    UserStatus.find_by_name('Inactive')
  end

  def button_style
    if self.name == 'Active'
      return 'btn-success'
    elsif self.name == 'Pending'
      return 'btn-warning'
    else
      return 'btn-danger'
    end
  end
end
