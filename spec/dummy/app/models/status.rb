class Status < ApplicationRecord
  include Authority::Abilities
  audited

  alias_attribute :to_s, :name
end
