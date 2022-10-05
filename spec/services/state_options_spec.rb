require 'rails_helper'

describe StateOptions, type: :service do
  describe 'name_for_code' do
    subject(:name_for_code) { described_class.name_for_code(code) }

    context 'when a valid state code is provided' do
      let(:code) { 'FL' }

      it 'returns the name' do
        expect(name_for_code).to eq 'Florida'
      end
    end

    context 'when an invalid state code is provided' do
      let(:code) { 'F1' }

      it 'returns nil' do
        expect(name_for_code).to be_nil
      end
    end
  end

  describe 'code_for_name' do
    subject(:code_for_name) { described_class.code_for_name(state_name) }

    context 'when a valid state name is provided' do
      let(:state_name) { 'Florida' }

      it 'returns the code' do
        expect(code_for_name).to eq 'FL'
      end
    end

    context 'when an invalid name is provided' do
      let(:state_name) { 'Califlorida' }

      it 'returns nil' do
        expect(code_for_name).to be_nil
      end
    end
  end
end
