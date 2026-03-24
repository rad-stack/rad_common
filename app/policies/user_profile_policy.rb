class UserProfilePolicy < ApplicationPolicy
  def update?
    return false unless RadConfig.user_profiles?

    record.allow_profile? && (user.permission?(:manage_user) || record == user)
  end
end
