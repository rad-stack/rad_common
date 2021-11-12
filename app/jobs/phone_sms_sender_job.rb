class PhoneSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, from_user_id, mobile_phone, media_url)
    PhoneSMSSender.new(message, from_user_id, mobile_phone, media_url).send!
  end
end
