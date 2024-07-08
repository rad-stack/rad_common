class UserSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, from_user_id, to_user_id, media_url, force_opt_out, record: nil)
    UserSMSSender.new(message, from_user_id, to_user_id, media_url, force_opt_out, record: record).send!
  end
end
