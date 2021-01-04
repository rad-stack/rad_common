class PhoneSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, mobile_phone)
    PhoneSMSSender.new(message, mobile_phone).send!
  end
end
