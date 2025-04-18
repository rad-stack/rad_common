module Hashable
  extend ActiveSupport::Concern

  def encoded_id
    return if id.nil?

    Hashable.hashids.encode(id)
  end

  def self.hashids
    Hashids.new(RadConfig.hash_key!, 6, RadConfig.hash_alphabet!)
  end

  class_methods do
    def find_decoded(encoded_id, col = :id)
      return unless encoded_id.present?

      encoded_id = encoded_id.gsub(/[^a-zA-Z\d]/, '')

      begin
        ids = Hashable.hashids.decode encoded_id
      rescue Hashids::InputError => e
        raise e if col == :id
        ids = []
      end

      return unless ids && ids.count == 1 && ids[0]

      col == :id ? find(ids[0]) : find_by(col => ids[0])
    end
  end
end
