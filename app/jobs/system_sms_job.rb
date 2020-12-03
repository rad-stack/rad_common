class SystemSMSJob < ApplicationJob
  queue_as :default

  def perform(message, recipient_id, media_url)
    RadicalSMSSender.new(message, recipient_id, media_url).send!
  end
end
