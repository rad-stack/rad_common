class NotificationTypePolicy < ApplicationPolicy
  def create?
    false
  end

  alias_method :destroy?, :create?
end
