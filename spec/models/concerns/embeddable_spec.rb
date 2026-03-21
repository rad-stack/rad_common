require 'rails_helper'

RSpec.describe Embeddable do
  let(:attorney) { create :attorney }

  before do
    create :admin
    allow(EmbeddingService).to receive(:enabled?).and_return true
  end

  it 'embeds vector data', :vcr do
    expect(attorney.embedding).not_to be_nil
  end

  it 'updates embeddings after change', :vcr do
    expect { attorney.update!(first_name: 'New Name') }.to(change { attorney.embedding.reload.embedding })
  end

  it 'does not update embeddings after unrelated change', :vcr do
    expect { attorney.update!(zipcode: '32216') }.not_to(change { attorney.embedding.reload.embedding })
  end
end
