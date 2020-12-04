require 'rails_helper'

RSpec.describe RadicalTwilio, type: :service do
  describe 'current_phone_number' do
    context 'with 3 numbers' do
      before { ENV['TWILIO_PHONE_NUMBERS'] = '9044444444,9044444445,9044444446' }

      it 'returns the numbers' do
        expect(described_class.new.current_from_number).to eq '9044444444'
        expect(described_class.new.current_from_number).to eq '9044444445'
        expect(described_class.new.current_from_number).to eq '9044444446'
        expect(described_class.new.current_from_number).to eq '9044444444'
        expect(described_class.new.current_from_number).to eq '9044444445'
      end
    end

    context 'with 1 number' do
      before { ENV['TWILIO_PHONE_NUMBERS'] = '9044444444' }

      it 'returns the number' do
        expect(described_class.new.current_from_number).to eq '9044444444'
        expect(described_class.new.current_from_number).to eq '9044444444'
        expect(described_class.new.current_from_number).to eq '9044444444'
      end
    end

    context 'with no numbers' do
      before { ENV['TWILIO_PHONE_NUMBERS'] = nil }

      it 'returns nil' do
        expect(described_class.new.current_from_number).to eq nil
      end
    end
  end
end
