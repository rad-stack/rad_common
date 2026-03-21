class NotificationTypePolicy < ApplicationPolicy
  def create?
    false
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      where_clause = '(id NOT IN (SELECT notification_type_id FROM notification_security_roles)) OR ' \
                     '(id IN (SELECT notification_type_id FROM notification_security_roles WHERE security_role_id IN ' \
                     '(SELECT security_role_id FROM user_security_roles WHERE user_id = ?) ))'

      scope.where(where_clause, user.id)
    end
  end
end
