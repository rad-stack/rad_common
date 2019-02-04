class Status < ApplicationRecord
  include Authority::Abilities
  audited

  def to_s
    name
  end

end
