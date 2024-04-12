require 'rails_helper'

RSpec.describe RadCommon::TwilioErrorThresholdChecker, type: :service do
  describe 'check_threshold' do
    let(:email) { ActionMailer::Base.deliveries.last }
    let(:body) { email.body.encoded }

    before { create :admin }

    context 'when threshold is exceeded' do
      before do
        2.times { create_list :contact_log_recipient, 10, service_status: :delivered }
        create_list :contact_log_recipient, 10, service_status: :undelivered
        described_class.new.check_threshold
      end

      it 'sends a notification' do
        expect(email.subject).to eq 'Twilio Error Threshold Exceeded'
        expect(body).to include 'Twilio Error Threshold has been exceeded. ' \
                                '33.33% of messages have failed to deliver. Check contact logs for more details'
      end
    end

    context 'when threshold is not exceeded' do
      before do
        create_list :contact_log_recipient, 10, service_status: :delivered
        create_list :contact_log_recipient, 1, service_status: :undelivered
        described_class.new.check_threshold
      end

      it 'does not sends a notification' do
        expect(email).to be_nil
      end
    end

    context 'when min failures is not exceeded' do
      before do
        create_list :contact_log_recipient, 2, service_status: :delivered
        create_list :contact_log_recipient, 8, service_status: :undelivered
        described_class.new.check_threshold
      end

      it 'does not sends a notification' do
        expect(email).to be_nil
      end
    end

    context 'when min failures is not exceeded and 100% are failures' do
      before do
        create_list :contact_log_recipient, 8, service_status: :undelivered
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
