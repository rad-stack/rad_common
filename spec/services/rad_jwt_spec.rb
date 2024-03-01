require 'rails_helper'

RSpec.describe RadJwt, type: :service do
  subject(:rad_jwt) { described_class.new }

  let(:period) { 1.minute }
  let(:key) { 'valid_key_length_that_is_at_least_256_bit' }

  before do
    allow(RadConfig).to receive(:jwt_secret!).and_return(key)
  end

  describe '#validate_key!' do
    context 'when key is valid length' do
      it 'does not raise error' do
        expect { rad_jwt }.not_to raise_error
      end
    end

    context 'when key is less than valid length' do
      let(:key) { 'short key' }

      it 'does raise error' do
        expect { rad_jwt }.to raise_error(described_class::InvalidJwtKeyLength)
      end
    end
  end
end
