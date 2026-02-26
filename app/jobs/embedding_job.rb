class EmbeddingJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError

  def perform(record)
    record.update_embedding!
  end
end
