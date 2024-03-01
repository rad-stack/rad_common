require 'rails_helper'

RSpec.describe RadRetry, type: :service do
  describe '#perform_request' do
    context 'when request fails' do
      let(:request_block) { raise OpenURI::HTTPError.new('foo', 'bar') }

      it 'retries the request' do
        expect(described_class).to receive(:exponential_pause).at_least(4).times
        expect {
          described_class.perform_request(no_delay: true) { request_block }
        }.to raise_error(RadIntermittentException)
      end

      context 'with retry count specified' do
        it 'retries the request specified number of times' do
          expect(described_class).to receive(:exponential_pause).twice
          expect {
            described_class.perform_request(no_delay: true, retry_count: 3) { request_block }
          }.to raise_error(RadIntermittentException)
        end
      end

      context 'with errors not included in RadRetry::RESCUABLE_ERRORS' do
        let(:request_block) { raise ActiveStorage::IntegrityError }

        it 'raises the error if not included in additional_erorrs' do
          expect(described_class).not_to receive(:exponential_pause)
          expect {
            described_class.perform_request(no_delay: true) { request_block }
          }.to raise_error(ActiveStorage::IntegrityError)
        end

        it 'rescues the error if included in additional_erorrs' do
          args = { no_delay: true, retry_count: 2, additional_errors: [ActiveStorage::IntegrityError] }
          expect(described_class).to receive(:exponential_pause)
          expect {
            described_class.perform_request(**args) { request_block }
          }.to raise_error(RadIntermittentException)
        end
      end
    end

    context 'when request succeeds' do
      let(:request_block) { 'Success' }

      it 'executes the block if there are no failures' do
        response = described_class.perform_request(no_delay: true) { request_block }
        expect(response).to eq(request_block)
      end
    end

    context 'with raise_original flag' do
      let(:request_block) { raise Twilio::REST::TwilioError }
      let(:args) { { no_delay: true, retry_count: 2, raise_original: raise_original } }

      context 'when true' do
        let(:raise_original) { true }

        it 'raises original error' do
          expect(described_class).to receive(:exponential_pause)
          expect {
            described_class.perform_request(**args) { request_block }
          }.to raise_error(Twilio::REST::TwilioError)
        end
      end

      context 'when false' do
        let(:raise_original) { false }

        it 'raises RadIntermittentException' do
          expect(described_class).to receive(:exponential_pause)
          expect {
            described_class.perform_request(**args) { request_block }
          }.to raise_error(RadIntermittentException)
        end
      end
    end
  end
end
