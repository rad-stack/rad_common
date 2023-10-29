require 'rails_helper'

RSpec.describe StringUtil do
  describe 'numeric?' do
    context 'with a string' do
      subject { described_class.numeric? input_value }

      context 'with zero' do
        let(:input_value) { '0' }

        it { is_expected.to be true }
      end

      context 'with leading zeros' do
        let(:input_value) { '001' }

        it { is_expected.to be true }
      end

      context 'with decimal' do
        let(:input_value) { '44.22' }

        it { is_expected.to be true }
      end

      context 'with trailing decimal' do
        let(:input_value) { '60.' }

        it { is_expected.to be false }
      end

      context 'with mixed alpha' do
        let(:input_value) { '22.24foo' }

        it { is_expected.to be false }
      end

      context 'with alpha' do
        let(:input_value) { 'foobar' }

        it { is_expected.to be false }
      end

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

        # the corresponding spec for integer? handles this differently, not sure if changing it would cause problems
        # in mayoplant project

        it { is_expected.to be true }
      end

      context 'with an underscore' do
        let(:input_value) { '123_456' }

        # the corresponding spec for integer? handles this differently, not sure if changing it would cause problems
        # in mayoplant project

        it { is_expected.to be true }
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

  describe 'integer?' do
    context 'with a string' do
      subject { described_class.integer? input_value }

      context 'with zero' do
        let(:input_value) { '0' }

        it { is_expected.to be true }
      end

      context 'with leading zeros' do
        let(:input_value) { '001' }

        it { is_expected.to be true }
      end

      context 'with decimal' do
        let(:input_value) { '44.22' }

        it { is_expected.to be false }
      end

      context 'with trailing decimal' do
        let(:input_value) { '60.' }

        it { is_expected.to be false }
      end

      context 'with mixed alpha' do
        let(:input_value) { '22.24foo' }

        it { is_expected.to be false }
      end

      context 'with alpha' do
        let(:input_value) { 'foobar' }

        it { is_expected.to be false }
      end

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
end
