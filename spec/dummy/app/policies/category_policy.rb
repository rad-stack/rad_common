class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  alias show? index?
  alias create? index?
end
