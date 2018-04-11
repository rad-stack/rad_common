class SecurityRole < ApplicationRecord
  include Authority::Abilities
  include RadSecurityRole

  def self.default_user
    SecurityRole.find_by(name: 'User')
  end

  def self.seed_items
    seed_admin
    seed_manager
    seed_user
  end

  class << self
    private def seed_admin
      group = get_group('Admin')
      seed_all group
      group.save!
    end

    private def seed_user
      group = get_group('User')
      group.read_division = true
      group.save!
    end

    private def seed_manager
      group = get_group('User')
      group.create_division = true
      group.read_division = true
      group.update_division = true
      group.save!
    end

    private def seed_all(group)
      group.admin = true
      group.read_audit = true
      group.read_user = true
      group.create_division = true
      group.read_division = true
      group.update_division = true
      group.delete_division = true
    end
  end
end
