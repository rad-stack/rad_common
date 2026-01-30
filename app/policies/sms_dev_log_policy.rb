class SmsDevLogPolicy < ApplicationPolicy
  def index?
    SmsLogStore.enabled?
  end

  def show?
    SmsLogStore.enabled?
  end

  def clear?
    SmsLogStore.enabled?
  end
end
