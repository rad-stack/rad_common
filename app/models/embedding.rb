class Embedding < ApplicationRecord
  has_neighbors :embedding

  belongs_to :embeddable, polymorphic: true

  scope :for_type, ->(type) { where(embeddable_type: type) }

  def self.search(embedding, limit: 10, type: nil, distance: nil)
    scope = all
    scope = scope.for_type(type) if type

    results = scope.where.not(embedding: nil)
                   .nearest_neighbors(:embedding, embedding, distance: 'cosine').limit(limit)
    return results if distance.blank?

    results.select { |ct| ct.neighbor_distance < distance }
  end
end
