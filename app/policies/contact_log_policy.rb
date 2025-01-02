class ContactLogPolicy < ApplicationPolicy
  def create?
    false
  end

  alias update? create?
  alias destroy? create?
end
