require 'rails_helper'

RSpec.describe Hashable do
  let!(:division) { create :division, id: 12_345 }

  describe 'encoded_id' do
    subject { division.encoded_id }

    let(:decoded_id) { 'kzwzey' }

    it { is_expected.to eq decoded_id }
  end

  describe 'find_decoded' do
    subject(:decoded) { Division.find_decoded decoded_id }

    context 'when record exists' do
      let(:decoded_id) { 'kzwzey' }

      it { is_expected.to eq division }
    end

    context 'when record does not exist' do
      let(:decoded_id) { described_class.hashids.encode(99_999) }

      it { expect { decoded }.to raise_error "Couldn't find Division with 'id'=99999" }
    end

    context 'when value cannot be decoded' do
      let(:decoded_id) { 'dmqali' }

      xit { expect { decoded }.to raise_error "Couldn't decode: dmqali" }
    end
  end
end
