class PhoneSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, contact_log_from_user_id, mobile_phone, media_url, force_opt_out, contact_log_record)
    PhoneSMSSender.new(message,
                       contact_log_from_user_id,
                       mobile_phone,
                       media_url,
                       force_opt_out,
                       contact_log_record: contact_log_record).send!
  end
end
