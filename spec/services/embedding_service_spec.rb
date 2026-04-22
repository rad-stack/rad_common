require 'rails_helper'

RSpec.describe EmbeddingService do
  describe '.generate' do
    it 'raises an error when text exceeds the max embedding size' do
      long_text = 'a' * (RadCommon::OPEN_AI_EMBEDDING_MAX_CHARS + 1)

      expect { described_class.generate(long_text) }
        .to raise_error(RuntimeError, /Text too large to embed/)
    end
  end
end
