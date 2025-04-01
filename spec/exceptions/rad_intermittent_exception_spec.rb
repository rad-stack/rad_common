require 'rails_helper'

RSpec.describe RadIntermittentException, type: :lib do
  context 'with custom message' do
    it 'raises with custom message' do
      message = 'foo'
      expect { raise described_class, message }.to raise_error(message)
    end
  end

  context 'with default message' do
    it 'raises with default message' do
      expect { raise described_class }.to raise_error('HTTP request failed')
    end
  end
end
