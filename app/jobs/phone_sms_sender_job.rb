class PhoneSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, from_user_id, mobile_phone, media_url, force_opt_out, contact_log_attachment_ids = nil)
    PhoneSMSSender.new(message, from_user_id, mobile_phone, media_url, force_opt_out, contact_log_attachment_ids).send!
  end
end
