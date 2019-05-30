class UserAuthorizer < ApplicationAuthorizer
  # class rules

  def self.creatable_by?(user)
    user.permission?(:manage_user)
  end

  def self.readable_by?(user)
    user.permission?(:manage_user)
  end

  def self.updatable_by?(user)
    user.permission?(:manage_user)
  end

  def self.deletable_by?(user)
    user.permission?(:manage_user) && user.internal?
  end
end
