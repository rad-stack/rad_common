require 'rails_helper'

RSpec.describe RadReports::FormulaProcessor, type: :service do
  describe '.call' do
    subject(:result) { described_class.call(formula, value, record) }

    let(:value) { 'test value' }
    let(:record) { nil }

    context 'with blank formula' do
      let(:formula) { nil }

      it 'returns original value' do
        expect(result).to eq 'test value'
      end
    end

    context 'with empty formula array' do
      let(:formula) { [] }

      it 'returns original value' do
        expect(result).to eq 'test value'
      end
    end

    context 'with non-array formula' do
      let(:formula) { 'not an array' }

      it 'returns original value' do
        expect(result).to eq 'test value'
      end
    end

    context 'with single transform' do
      let(:formula) do
        [
          { 'type' => 'UPPER', 'params' => {} }
        ]
      end

      it 'applies transform' do
        expect(result).to eq 'TEST VALUE'
      end
    end

    context 'with multiple transforms' do
      let(:formula) do
        [
          { 'type' => 'UPPER', 'params' => {} },
          { 'type' => 'TRUNCATE', 'params' => { 'length' => 4, 'suffix' => '...' } }
        ]
      end

      it 'applies transforms in sequence' do
        expect(result).to eq 'T...'
      end
    end

    context 'with transform params' do
      let(:formula) do
        [
          { 'type' => 'CONCAT', 'params' => { 'text' => ' suffix' } }
        ]
      end

      it 'passes params to transform' do
        expect(result).to eq 'test value suffix'
      end
    end

    context 'with missing params' do
      let(:formula) do
        [
          { 'type' => 'UPPER' }
        ]
      end

      it 'defaults params to empty hash' do
        expect(result).to eq 'TEST VALUE'
      end
    end

    context 'with numeric value and math transform' do
      let(:value) { 10 }
      let(:formula) do
        [
          { 'type' => 'MULTIPLY', 'params' => { 'factor' => 2.5 } }
        ]
      end

      it 'applies math transform' do
        expect(result).to eq 25.0
      end
    end

    context 'with invalid formula type' do
      let(:formula) do
        [
          { 'type' => 'INVALID_TRANSFORM', 'params' => {} }
        ]
      end

      it 'returns original value' do
        expect(result).to eq 'test value'
      end
    end
  end
end
