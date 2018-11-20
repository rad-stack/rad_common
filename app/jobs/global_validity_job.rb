class GlobalValidityJob < ApplicationJob
  queue_as :default

  def perform(current_user)
    problems = Company.main.check_global_validity

    if problems.any?
      RadbearMailer.global_validity([current_user], problems).deliver_later
    else
      message = "No invalid data found"
      RadbearMailer.simple_message(current_user, message, message).deliver_later
    end
  end
end
