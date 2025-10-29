class EmbeddingJob < ApplicationJob
  queue_as :default

  def perform(record)
    record.update_embedding!
  end
end
