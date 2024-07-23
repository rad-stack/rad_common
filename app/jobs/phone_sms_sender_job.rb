class PhoneSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, from_user_id, mobile_phone, media_url, force_opt_out)
    PhoneSMSSender.new(message, from_user_id, mobile_phone, media_url, force_opt_out).send!
  end
end
