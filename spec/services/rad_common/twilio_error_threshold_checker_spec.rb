require 'rails_helper'

RSpec.describe RadCommon::TwilioErrorThresholdChecker, type: :service do
  describe 'check_threshold' do
    let(:email) { ActionMailer::Base.deliveries.last }
    let(:body) { email.body.encoded }

    before { create :admin }

    context 'when threshold is exceeded' do
      before do
        create_list :contact_log, 23, twilio_status: :delivered
        create_list :contact_log, 10, twilio_status: :undelivered
        described_class.new.check_threshold
      end

      it 'sends a notification' do
        expect(email.subject).to eq 'Twilio Error Threshold Exceeded'
        expect(body).to include 'Twilio Error Threshold has been exceeded. 30.3% of messages have failed to deliver. ' \
                                'Check contact logs for more details'
      end
    end

    context 'when threshold is not exceeded' do
      before do
        create_list :contact_log, 24, twilio_status: :delivered
        create_list :contact_log, 1, twilio_status: :undelivered
        described_class.new.check_threshold
      end

      it 'does not sends a notification' do
        expect(email).to be_nil
      end
    end

    context 'when min failures is not exceeded' do
      before do
        create_list :contact_log, 2, twilio_status: :delivered
        create_list :contact_log, 8, twilio_status: :undelivered
        described_class.new.check_threshold
      end

      it 'does not sends a notification' do
        expect(email).to be_nil
      end
    end

    context 'when min failures is not exceeded and 100% are failures' do
      before do
        create_list :contact_log, 8, twilio_status: :undelivered
        described_class.new.check_threshold
      end

      it 'sends a notification' do
        expect(email.subject).to eq 'Twilio Error Threshold Exceeded'
        expect(body).to include 'Twilio Error Threshold has been exceeded. 100% of messages have failed ' \
                                'to deliver. Check contact logs for more details'
      end
    end
  end
end
