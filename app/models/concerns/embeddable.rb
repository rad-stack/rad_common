module Embeddable
  extend ActiveSupport::Concern

  included do
    has_one :embedding, as: :embeddable, dependent: :destroy
    scope :needs_embedding, -> { where.missing(:embedding).order(created_at: :desc) }
    after_create_commit :update_embedding!, if: -> { EmbeddingService.enabled? && !seeding }
  end

  def update_embedding!
    content = generate_embedding_content

    embedding_vector = EmbeddingService.generate(content)
    return unless embedding_vector

    embedding_record = embedding || build_embedding
    embedding_record.update! embedding: embedding_vector, metadata: embedding_metadata
  end
end
