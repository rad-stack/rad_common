class AttorneyPolicy < ApplicationPolicy
  def index?
    true
  end

  alias show? index?
end
