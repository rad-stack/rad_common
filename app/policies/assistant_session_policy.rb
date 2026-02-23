class AssistantSessionPolicy < ApplicationPolicy
  def chat_response?
    update?
  end

  def check_response?
    update?
  end

  def reset_chat?
    update?
  end

  def create?
    RadConfig.open_ai_api_key.present? && user.permission?(:admin)
  end
end
