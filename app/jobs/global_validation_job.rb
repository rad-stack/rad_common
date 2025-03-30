class GlobalValidationJob < ApplicationJob
  queue_as :default

  def perform(current_user, single_model)
    global_validity = GlobalValidation.new
    global_validity.override_model = single_model if single_model.present?
    problems = global_validity.check_global_validity

    if problems.any?
      RadMailer.global_validity_on_demand(current_user, problems).deliver_now
    else
      message = 'No invalid data found'
      RadMailer.simple_message(current_user, message, message, contact_log_from_user: current_user).deliver_now
    end
  end
end
