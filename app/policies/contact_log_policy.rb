class ContactLogPolicy < ApplicationPolicy
  def create?
    false
  end

  alias destroy? create?
  alias update? create?
end
