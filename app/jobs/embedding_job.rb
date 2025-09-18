class EmbeddingJob < ApplicationJob
  queue_as :default

  def perform(embeddable)
    embeddable.update_embedding!
  end
end
