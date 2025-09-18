module Embeddable
  extend ActiveSupport::Concern

  included do
    has_one :embedding, as: :embeddable, dependent: :destroy
    after_create_commit :update_embedding!, if: -> { EmbeddingService.enabled? && !seeding }
  end
end
