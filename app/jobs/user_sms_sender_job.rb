class UserSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, contact_log_from_user_id, to_user_id, media_url, force_opt_out, contact_log_record: nil)
    UserSMSSender.new(message, contact_log_from_user_id, to_user_id, media_url, force_opt_out, contact_log_record: contact_log_record).send!
  end
end
