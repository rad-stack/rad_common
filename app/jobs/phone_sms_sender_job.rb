class PhoneSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, from_user_id, mobile_phone)
    PhoneSMSSender.new(message, from_user_id, mobile_phone).send!
  end
end
