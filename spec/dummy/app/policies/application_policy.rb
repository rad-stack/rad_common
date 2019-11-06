class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.permission?(:admin)
  end

  def show?
    user.permission?(:admin)
  end

  def create?
    user.permission?(:admin)
  end

  def new?
    create?
  end

  def update?
    user.permission?(:admin)
  end

  def edit?
    update?
  end

  def destroy?
    user.permission?(:admin)
  end

  def audit?
    user.permission?(:admin)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
