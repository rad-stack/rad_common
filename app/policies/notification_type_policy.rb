class NotificationTypePolicy < ApplicationPolicy
  def create?
    false
  end

  alias destroy? create?
end
