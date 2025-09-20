module Embeddable
  extend ActiveSupport::Concern

  included do
    has_one :embedding, as: :embeddable, dependent: :destroy
    scope :needs_embedding, -> { where.missing(:embedding).order(created_at: :desc) }
    after_create_commit :update_embedding!, if: -> { EmbeddingService.enabled? && !seeding }
  end

  def update_embedding!
    raise 'wrong type' unless embedding_metadata.is_a?(Hash)
    return if embedding_vector.blank? # TODO: why would this be nil?

    embedding_record = embedding || build_embedding
    embedding_record.update! embedding: embedding_vector, metadata: embedding_metadata.compact_blank
  end

  private

    def embedding_vector
      @embedding_vector ||= EmbeddingService.new(generate_embedding_content).generate
    end
end
