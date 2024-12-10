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

  def export?
    user.permission?(:admin)
  end

  def global_search?
    index?
  end

  alias not_duplicate? destroy?
  alias reset_duplicates? destroy?
  alias merge_duplicates? destroy?
  alias index_duplicates? index?
  alias duplicate_do_later? destroy?

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
