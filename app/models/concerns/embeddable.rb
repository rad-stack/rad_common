module Embeddable
  extend ActiveSupport::Concern

  included do
    has_one :embedding, as: :embeddable, dependent: :destroy
    scope :needs_embedding, -> { where.missing(:embedding).order(created_at: :desc) }

    after_commit :perform_embedding!,
                 on: %i[create update],
                 if: -> { EmbeddingService.enabled? && !seeding && embedding_changed? }
  end

  def update_embedding!
    content = if summarizer.present?
                summarizer.summarize
              else
                generate_embedding_content
              end

    embedding_vector = EmbeddingService.generate(content)
    return unless embedding_vector

    association(:embedding).reload
    embedding_record = embedding || build_embedding
    embedding_record.update! embedding: embedding_vector
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
