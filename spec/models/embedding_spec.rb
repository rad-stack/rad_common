require 'rails_helper'

RSpec.describe Embedding do
  describe 'metadata default' do
    it 'defaults metadata to empty hash when not provided' do
      embedding = described_class.create!(
        embeddable: create(:user),
        embedding: Array.new(1536) { rand }
      )

      expect(embedding.metadata).to eq({})
    end
  end
end
