module Embeddable
  extend ActiveSupport::Concern

  included do
    has_one :embedding, as: :embeddable, dependent: :destroy
    scope :needs_embedding, -> { where.missing(:embedding).order(created_at: :desc) }
    after_create_commit :perform_embedding!, if: -> { EmbeddingService.enabled? && !seeding }
    after_update_commit :perform_embedding!, if: -> { EmbeddingService.enabled? && !seeding && embedding_changed? }
  end

  def update_embedding!
    content = if summarizer.present?
                summarizer.summarize
              else
                generate_embedding_content
              end

    embedding_vector = EmbeddingService.generate(content)
    return unless embedding_vector

    embedding_record = embedding || build_embedding
    embedding_record.update! embedding: embedding_vector, metadata: embedding_metadata.compact_blank
  end

  def summarizer
    nil
  end

  private

    def embedding_changed?
      raise NotImplementedError
    end

    def perform_embedding!
      EmbeddingJob.perform_later(self)
    end
end
