require 'rails_helper'

RSpec.describe StringUtil do
  context 'with a string' do
    subject { described_class.integer? input_value }

    context 'with just integers' do
      let(:input_value) { '123' }

      it { is_expected.to be true }
    end

    context 'with a middle space' do
      let(:input_value) { '12 3' }

      it { is_expected.to be false }
    end

    context 'with a leading space' do
      let(:input_value) { ' 123' }

      it { is_expected.to be false }
    end

    context 'with an underscore' do
      let(:input_value) { '123_456' }

      it { is_expected.to be false }
    end

    context 'with a dash' do
      let(:input_value) { '123-456' }

      it { is_expected.to be false }
    end
  end

  context 'with a non-string' do
    let(:input_value) { 123 }

    it 'raises an exception' do
      expect { described_class.integer? input_value }.to raise_error 'input value is not a string'
    end
  end

  context 'with nil' do
    let(:input_value) { nil }

    it 'raises an exception' do
      expect { described_class.integer? input_value }.to raise_error 'input value is not a string'
    end
  end
end
