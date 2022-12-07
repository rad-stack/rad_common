require 'rails_helper'

RSpec.describe RadCommon::TwilioErrorThresholdChecker, type: :service do
  describe 'check_threshold' do
    let!(:user) { create :admin }
    let(:email) { ActionMailer::Base.deliveries.last }
    let(:body) { email.body.encoded }

    context 'when threshold is passed' do
      before do
        create_list :twilio_log, 23, twilio_status: :delivered
        create_list :twilio_log, 2, twilio_status: :undelivered
        described_class.new.check_threshold
      end

      it 'sends a notification' do
        expect(email.subject).to eq 'Twilio Error Threshold Passed'
        expect(body).to include 'Twilio Error Threshold has been passed. 8.0% of messages have failed to deliver. ' \
                                'Check twilio logs for more details'
      end
    end

    context 'when threshold is not passed' do
      before do
        create_list :twilio_log, 24, twilio_status: :delivered
        create_list :twilio_log, 1, twilio_status: :undelivered
        described_class.new.check_threshold
      end

      it 'does not sends a notification' do
        expect(email).to be_nil
      end
    end
  end
end
