class Embedding < ApplicationRecord
  has_neighbors :embedding

  belongs_to :embeddable, polymorphic: true

  scope :for_type, ->(type) { where(embeddable_type: type) }
  scope :with_metadata, ->(metadata_query) { where('metadata @> ?', metadata_query.to_json) }

  def self.search(query_embedding, limit: 10, type: nil, metadata_filters: {})
    scope = all
    scope = scope.for_type(type) if type
    scope = scope.with_metadata(metadata_filters) unless metadata_filters.empty?

    scope.where.not(embedding: nil)
         .order(Arel.sql("embedding <-> '[#{query_embedding.join(',')}]'"))
         .limit(limit)
  end
end
