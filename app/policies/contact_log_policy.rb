class ContactLogPolicy < ApplicationPolicy
  def create?
    false
  end

  alias show? create?
  alias destroy? create?
  alias update? create?
end
