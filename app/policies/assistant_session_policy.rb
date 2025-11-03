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
end
