class CompanyPolicy < ApplicationPolicy
  def global_validity_check?
    user.permission?(:admin)
  end
end
