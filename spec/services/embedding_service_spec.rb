require 'rails_helper'

RSpec.describe EmbeddingService do
  describe '.needs_chunking?' do
    it 'returns false for short text' do
      expect(described_class.needs_chunking?('short text')).to be false
    end

    it 'returns true for text exceeding max chars' do
      long_text = 'a' * (RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS + 1)
      expect(described_class.needs_chunking?(long_text)).to be true
    end
  end

  describe '.chunk_text' do
    it 'returns single-element array for short text' do
      result = described_class.chunk_text('short text')
      expect(result).to eq(['short text'])
    end

    it 'splits long text into overlapping chunks' do
      long_text = 'a' * (RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS + 1_000)
      chunks = described_class.chunk_text(long_text)

      expect(chunks.size).to be > 1
      expect(chunks.all? { |c| c.length <= RadCommon::OPEN_AI_EMBEDDING_CHUNK_SIZE }).to be true
    end

    it 'produces overlapping chunks' do
      chunk_size = RadCommon::OPEN_AI_EMBEDDING_CHUNK_SIZE
      overlap = RadCommon::OPEN_AI_EMBEDDING_CHUNK_OVERLAP
      long_text = (0..99_999).map { |i| i.to_s.rjust(5, '0') }.join

      chunks = described_class.chunk_text(long_text)

      next unless chunks.size >= 2

      first_chunk_end = long_text[chunk_size - overlap, overlap]
      second_chunk_start = chunks[1][0, overlap]
      expect(first_chunk_end).to eq(second_chunk_start)
    end

    it 'covers the entire text' do
      long_text = 'x' * (RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS + 5_000)
      chunks = described_class.chunk_text(long_text)

      chunk_size = RadCommon::OPEN_AI_EMBEDDING_CHUNK_SIZE
      overlap = RadCommon::OPEN_AI_EMBEDDING_CHUNK_OVERLAP
      step = chunk_size - overlap
      expected_chunks = ((long_text.length - overlap).to_f / step).ceil

      expect(chunks.size).to eq(expected_chunks)
    end
  end
end
