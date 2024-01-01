require 'rails_helper'

RSpec.describe RadRateLimiter, type: :service do
  subject(:rate_limiter) { described_class.new(limit: 5, period: 1, key: 'foo') }

  after { Rails.cache.clear }

  describe '#check_rate_limit!' do
    context 'when requests in period are greater than limit' do
      before { 5.times { rate_limiter.run { 'foo' } } }

      it 'raises error' do
        expect { rate_limiter.run { 'foo' } }.to raise_error(described_class::RateLimitExceededError)
      end
    end

    context 'when requests in period are less than limit' do
      before { 4.times { rate_limiter.run { 'foo' } } }

      it 'raises error' do
        expect { rate_limiter.run { 'foo' } }.not_to raise_error(described_class::RateLimitExceededError)
      end
    end
  end
end
