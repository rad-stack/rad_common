class CustomReportPolicy < ApplicationPolicy
  def update_joins?
    update?
  end

  def update_filters?
    update?
  end

  def update_columns?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
