class SendgridStatusReceiverJob < ApplicationJob
  queue_as :default

  def perform(content)
    SendgridStatusReceiver.new(content).process!
  end
end
