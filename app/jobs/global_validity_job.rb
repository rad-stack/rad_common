class GlobalValidityJob < ApplicationJob
  queue_as :default

  def perform(company, current_user)
    problems = company.check_global_validity

    if problems.any?
      RadbearMailer.global_validity(company, [current_user], problems).deliver_later
    else
      message = "No invalid data found in company #{company.name}"
      RadbearMailer.simple_message(company, current_user, message, message).deliver_later
    end
  end
end
