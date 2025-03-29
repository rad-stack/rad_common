require 'rails_helper'

RSpec.describe PhoneSMSSender, type: :service do
  let(:from_user) { create :user }
  let(:to_user) { create :user, mobile_phone: '(618) 722-2169' }
  let(:mobile_phone) { to_user.mobile_phone }
  let(:message) { 'test message' }
  let(:client) { create :client }
  let(:sms_sender) { described_class.new(message, from_user.id, mobile_phone, nil, false, contact_log_record: client) }

  before { allow(RadRetry).to receive(:exponential_pause) }

  describe 'send', :vcr do
    subject(:result) { sms_sender.send! }

    context 'when operating normally' do
      context 'when successful' do
        it 'is true and creates a contact log' do
          expect { result }.to change(ContactLog, :count).by(1)
          expect(result).to be(true)
          expect(ContactLog.last.from_user).to eq from_user
          expect(ContactLog.last.record).to eq client
        end

        it 'sets to user if phone number matches' do
          expect { result }.to change(ContactLogRecipient, :count).by(1)
          expect(ContactLogRecipient.last.to_user).to eq to_user
        end

        it "doesn't set to user if more than one user has the phone number" do
          create :user, mobile_phone: mobile_phone

          expect { result }.to change(ContactLogRecipient, :count).by(1)
          expect(ContactLogRecipient.last.to_user).to be_nil
        end
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

  describe 'augment_message' do
    subject { sms_sender.send(:augment_message, message, force_opt_out) }

    let(:force_opt_out) { false }

    context 'with full question' do
      let(:message) { 'Hey man, can I borrow your surfboard?' }

      it { is_expected.to eq 'Hey man, can I borrow your surfboard? To no longer receive text messages, text STOP.' }
    end

    context 'with full sentence' do
      let(:message) { 'Your surfboard is lame.' }

      it { is_expected.to eq 'Your surfboard is lame. To no longer receive text messages, text STOP.' }
    end

    context 'without full sentence' do
      let(:message) { "I'm taking your surfboard" }

      it { is_expected.to eq "I'm taking your surfboard - To no longer receive text messages, text STOP" }

      context 'when opt out message already sent' do
        before { create :contact_log, sms_opt_out_message_sent: true, sent: true, phone_number: mobile_phone }

        it { is_expected.to eq "I'm taking your surfboard" }

        context 'with force opt out option' do
          let(:force_opt_out) { true }

          it { is_expected.to eq "I'm taking your surfboard - To no longer receive text messages, text STOP" }
        end
      end
    end
  end
end
