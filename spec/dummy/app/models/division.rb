class Division < ApplicationRecord
  include Authority::Abilities

  belongs_to :owner, class_name: 'User'
  alias_attribute :to_s, :name
  scope :authorized, ->(_){}

  audited
end
