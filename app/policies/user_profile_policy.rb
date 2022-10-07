class UserProfilePolicy < ApplicationPolicy
  def show?
    return false unless RadicalConfig.user_profiles?

    record.allow_profile? && (user.permission?(:manage_user) || record == user)
  end

  alias update? show?
end
