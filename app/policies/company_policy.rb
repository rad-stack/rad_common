class CompanyPolicy < ApplicationPolicy
  def jwt?
    user.permission?(:admin)
  end
end
