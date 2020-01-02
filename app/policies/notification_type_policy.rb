class NotificationTypePolicy < ApplicationPolicy
  def create?
    false
  end

  alias destroy? create?

  class Scope < Scope
    def resolve
      where_clause = 'notification_types.auth_mode = 1 OR '\
                     '(id IN (SELECT notification_type_id FROM notification_security_roles WHERE security_role_id IN '\
                     '(SELECT security_role_id FROM security_roles_users WHERE user_id = ?) ))'

      scope.where(where_clause, user.id)
    end
  end
end
