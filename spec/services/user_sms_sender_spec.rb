require 'rails_helper'

RSpec.describe UserSMSSender, type: :service do
  let(:from_user) { create :user }
  let(:user) { create :user, mobile_phone: '(618) 722-2169' }
  let(:message) { 'test message' }
  let(:media_url) { nil }
  let(:sms_sender) { described_class.new(message, from_user.id, user.id, media_url, false) }
  let(:last_email) { ActionMailer::Base.deliveries.last }

  before do
    allow(RadRetry).to receive(:exponential_pause)
    allow_any_instance_of(PhoneSMSSender).to receive(:log_attachments)
  end

  describe 'send', :vcr do
    context 'when operating normally' do
      subject { last_email }

      before do
        ActionMailer::Base.deliveries = []
        sms_sender.send!
      end

      context 'when successful SMS' do
        it { is_expected.to be_nil }
      end

      context 'when successful MMS' do
        let(:media_url) { 'http://example.com/foo.jpg' }

        it { is_expected.to be_nil }
      end

      context 'when failure' do
        context 'when blacklisted' do
          let(:user) { create :user, :external, mobile_phone: '(500) 555-0004' }

          it { is_expected.not_to be_nil }

          it 'has the correct email subject' do
            expect(last_email.subject).to include 'SMS Message from'
          end
        end
      end
    end

    context 'when not operating normally' do
      let(:user) { create :user, mobile_phone: '(500) 555-0009' }

      it 'raises exception' do
        expect { sms_sender.send! }.to raise_error RuntimeError
      end
    end
  end
end
