class Embedding < ApplicationRecord
  has_neighbors :embedding

  belongs_to :embeddable, polymorphic: true

  scope :for_type, ->(type) { where(embeddable_type: type) }

  def self.search(embedding, limit: 10, type: nil, distance: nil)
    scope = all
    scope = scope.for_type(type) if type

    results = scope.where.not(embedding: nil)
                   .nearest_neighbors(:embedding, embedding, distance: 'cosine')

    results = if distance.present?
                results.select { |ct| ct.neighbor_distance < distance }
              else
                results.to_a
              end

    deduplicate_results(results, limit)
  end

  def self.deduplicate_results(results, limit)
    seen = {}

    results.each do |result|
      key = [result.embeddable_type, result.embeddable_id]

      if seen[key].nil? || result.neighbor_distance < seen[key].neighbor_distance
        seen[key] = result
      end
    end

    seen.values.sort_by(&:neighbor_distance).first(limit)
  end

  private_class_method :deduplicate_results
end
