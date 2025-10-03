class FaxSenderJob < ApplicationJob
  queue_as :default

  def perform(contact_log)
    FaxSender.new(contact_log).send!
  end
end
