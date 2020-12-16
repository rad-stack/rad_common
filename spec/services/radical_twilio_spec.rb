require 'rails_helper'

RSpec.describe RadicalTwilio, type: :service do
  describe 'full_body' do
    subject { described_class.new.send(:full_body, message) }

    context 'with full question' do
      let(:message) { 'Hey man, can I borrow your surfboard?' }

      it { is_expected.to eq 'Hey man, can I borrow your surfboard? Reply STOP to unsubscribe.' }
    end

    context 'with full sentence' do
      let(:message) { 'Your surfboard is lame.' }

      it { is_expected.to eq 'Your surfboard is lame. Reply STOP to unsubscribe.' }
    end

    context 'without full sentence' do
      let(:message) { "I'm taking your surfboard" }

      it { is_expected.to eq "I'm taking your surfboard - Reply STOP to unsubscribe" }
    end
  end

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
