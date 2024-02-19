class ClientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.external?
        scope.where('clients.id IN (SELECT client_id FROM user_clients WHERE user_id = ?)', user.id)
      else
        scope.all
      end
    end
  end
end
