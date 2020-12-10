class UserSMSSenderJob < ApplicationJob
  queue_as :default

  def perform(message, recipient_id, media_url)
    UserSMSSender.new(message, recipient_id, media_url).send!
  end
end
