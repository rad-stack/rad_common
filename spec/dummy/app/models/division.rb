class Division < ApplicationRecord
  include Authority::Abilities

  belongs_to :owner, class_name: 'User'

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :authorized, ->(_) {}

  audited
end
