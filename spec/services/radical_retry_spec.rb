require 'rails_helper'

RSpec.describe RadicalRetry, type: :service do
  describe '#perform_request' do
    context 'request fails' do
      let(:request_block) { raise OpenURI::HTTPError.new('foo', 'bar') }

      it 'retries the request' do
        expect(described_class).to receive(:exponential_pause).at_least(4).times
        expect {
          described_class.perform_request(no_delay: true) { request_block }
        }.to raise_error(OpenURI::HTTPError)
      end

      context 'with retry count specified' do
        it 'retries the request specified number of times' do
          expect(described_class).to receive(:exponential_pause).twice
          expect {
            described_class.perform_request(no_delay: true, retry_count: 3) { request_block }
          }.to raise_error(OpenURI::HTTPError)
        end
      end

      context 'with errors not included in RadicalRetry::RESCUABLE_ERRORS' do
        let(:request_block) { raise ActiveStorage::IntegrityError }

        it 'raises the error if not included in additional_erorrs' do
          expect(described_class).not_to receive(:exponential_pause)
          expect {
            described_class.perform_request(no_delay: true) { request_block }
          }.to raise_error(ActiveStorage::IntegrityError)
        end

        it 'rescues the error if included in additional_erorrs' do
          expect(described_class).to receive(:exponential_pause)
          expect {
            described_class.perform_request(no_delay: true, retry_count: 2, additional_errors: [ActiveStorage::IntegrityError]) { request_block }
          }.to raise_error(ActiveStorage::IntegrityError)
        end
      end
    end

    context 'request succeeds' do
      let(:request_block) { 'Success' }

      it 'executes the block if there are no failures' do
        response = described_class.perform_request(no_delay: true) { request_block }
        expect(response).to eq(request_block)
      end
    end
  end
end
