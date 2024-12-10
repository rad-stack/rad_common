class GlobalValidationJob < ApplicationJob
  queue_as :default

  def perform(current_user, single_model)
    global_validity = GlobalValidation.new
    global_validity.override_model = single_model if single_model.present?
    problems = global_validity.check_global_validity

    if problems.any?
      RadbearMailer.global_validity_on_demand(current_user, problems).deliver_later
    else
      message = 'No invalid data found'
      RadbearMailer.simple_message(current_user, message, message).deliver_later
    end
  end
end
