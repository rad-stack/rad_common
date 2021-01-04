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
end
