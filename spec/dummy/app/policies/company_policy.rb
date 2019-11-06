class CompanyPolicy < ApplicationPolicy
  def global_validate?
    user.permission?(:admin)
  end
end
