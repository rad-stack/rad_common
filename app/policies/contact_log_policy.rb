class ContactLogPolicy < ApplicationPolicy
  def create?
    false
  end

  alias destroy? create?
  alias update? create?
  alias related_to? index?
end
