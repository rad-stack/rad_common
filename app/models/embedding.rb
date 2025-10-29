class Embedding < ApplicationRecord
  has_neighbors :embedding

  belongs_to :embeddable, polymorphic: true

  scope :for_type, ->(type) { where(embeddable_type: type) }
  scope :with_metadata, ->(metadata_query) { where('metadata @> ?', metadata_query.to_json) }

  def self.search(embedding, limit: 10, type: nil, metadata_filters: {}, distance: nil)
    scope = all
    scope = scope.for_type(type) if type
    scope = scope.with_metadata(metadata_filters) unless metadata_filters.empty?

    results = scope.where.not(embedding: nil)
                   .nearest_neighbors(:embedding, embedding, distance: 'cosine').limit(limit)
    return results if distance.blank?

    results.select { |ct| ct.neighbor_distance < distance }
  end
end
