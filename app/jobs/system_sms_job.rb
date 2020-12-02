class SystemSMSJob < ApplicationJob
  queue_as :default

  def perform(message, recipients, current_user, media_url)
    RadicalSmsSender.new(message, recipients, current_user, media_url).send!
  end
end
