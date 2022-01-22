class CustomerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.external?
        scope.where('customers.id IN (SELECT customer_id FROM user_customers WHERE user_id = ?)', user.id)
      else
        scope.all
      end
    end
  end
end
