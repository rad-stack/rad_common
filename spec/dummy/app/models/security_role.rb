class SecurityRole < ApplicationRecord
  include RadSecurityRole

  def self.seed_items
    seed_admin
    seed_user
    seed_manager
  end

  class << self
    private def seed_manager
      group = get_group('Manager')
      group.create_division = true
      group.read_division = true
      group.update_division = true
      group.save!
    end
  end
end
