require 'rails_helper'

describe StateOptions, type: :service do
  describe '.full_name' do
    subject(:full_name) { described_class.full_name(abbreviation) }

    context 'when a valid state abbreviation is provided' do
      let(:abbreviation) { 'FL' }

      it 'returns the full name of the state' do
        expect(full_name).to eq 'Florida'
      end
    end

    context 'when an invalid state abbreviation is provided' do
      let(:abbreviation) { 'F1' }

      it 'returns nil' do
        expect(full_name).to be_nil
      end
    end
  end
end
