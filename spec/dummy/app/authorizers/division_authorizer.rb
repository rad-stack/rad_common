class DivisionAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.permission?(:create_division)
  end

  def self.readable_by?(user)
    user.permission?(:read_division)
  end

  def self.updatable_by?(user)
    user.permission?(:update_division)
  end

  def self.deletable_by?(user)
    user.permission?(:delete_division)
  end
end
