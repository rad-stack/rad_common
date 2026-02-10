class CustomReportPolicy < ApplicationPolicy
  def update_joins?
    update?
  end

  def edit_configuration?
    update?
  end

  def update_configuration?
    update?
  end

  def update_filters?
    update?
  end

  def update_columns?
    update?
  end

  def model_context?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
