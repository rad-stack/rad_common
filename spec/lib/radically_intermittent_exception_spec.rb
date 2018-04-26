require 'rails_helper'

RSpec.describe RadicallyIntermittentException, type: :lib do
  context 'custom message' do
    it 'raises with custom message' do
      message = 'foo'
      expect { raise described_class.new(message) }.to raise_error(message)
    end
  end

  context 'default message' do
    it 'raises with default message' do
      expect{ raise described_class }.to raise_error('HTTP request failed')
    end
  end
end
