require 'rails_helper'

RSpec.describe Embeddable do
  let(:attorney) { create :attorney }

  before { allow(EmbeddingService).to receive(:enabled?).and_return true }

  it 'embeds vector data', :vcr do
    expect(attorney.embedding).not_to be_nil
  end
end
