class SMSDevLogPolicy < ApplicationPolicy
  def index?
    SMSLogStore.enabled?
  end

  def show?
    SMSLogStore.enabled?
  end

  def clear?
    SMSLogStore.enabled?
  end
end
