class UserProfilePolicy < ApplicationPolicy
  def show?
    return false unless RadConfig.user_profiles?

    record.allow_profile? && (user.permission?(:manage_user) || record == user)
  end

  alias update? show?
end
