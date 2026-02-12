module Embeddable
  extend ActiveSupport::Concern

  included do
    has_many :embeddings, as: :embeddable, dependent: :destroy
    scope :needs_embedding, -> { where.missing(:embeddings).order(created_at: :desc) }

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

    chunks = EmbeddingService.chunk_text(content)

    association(:embeddings).reload

    chunks.each_with_index do |chunk, index|
      embedding_vector = EmbeddingService.generate(chunk)
      next unless embedding_vector

      embedding_record = embeddings.find_or_initialize_by(chunk_index: index)
      embedding_record.update!(embedding: embedding_vector)
    end

    embeddings.where('chunk_index >= ?', chunks.size).destroy_all
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
