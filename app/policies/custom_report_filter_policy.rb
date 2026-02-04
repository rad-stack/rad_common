class CustomReportFilterPolicy < ApplicationPolicy
  def new?
    CustomReportPolicy.new(user, CustomReport).new?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end
end
