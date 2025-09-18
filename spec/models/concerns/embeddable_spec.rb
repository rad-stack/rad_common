require 'rails_helper'

RSpec.describe Embeddable do
  let(:division) { create :division }

  before { allow(EmbeddingService).to receive(:enabled?).and_return true }

  it 'embeds vector data', :vcr do
    expect(division.embedding).not_to be_nil
  end
end
