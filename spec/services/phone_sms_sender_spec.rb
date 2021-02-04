require 'rails_helper'

RSpec.describe PhoneSMSSender, type: :service do
  let(:from_user) { create :user }
  let(:mobile_phone) { '(618) 722-2169' }
  let(:message) { 'test message' }
  let(:sms_sender) { described_class.new(message, from_user.id, mobile_phone) }

  describe 'send', :vcr do
    subject(:result) { sms_sender.send! }

    context 'when operating normally' do
      context 'when successful' do
        it { is_expected.to be true }
      end

      context 'when failure' do
        context 'when blacklisted' do
          let(:mobile_phone) { '(500) 555-0004' }

          it { is_expected.to be false }
        end
      end
    end

    context 'when not operating normally' do
      let(:mobile_phone) { '(500) 555-0009' }

      it 'raises exception' do
        expect { result }.to raise_error RuntimeError
      end
    end
  end
end
