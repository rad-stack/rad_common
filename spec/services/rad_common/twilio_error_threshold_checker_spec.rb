require 'rails_helper'

RSpec.describe RadCommon::TwilioErrorThresholdChecker, type: :service do
  describe 'passed_error_threshold?' do
    subject { described_class.passed_error_threshold? }

    context 'when threshold is passed' do
      before do
        create_list :twilio_log, 23, twilio_status: :delivered
        create_list :twilio_log, 2, twilio_status: :undelivered
      end

      it { is_expected.to be true }
    end

    context 'when threshold is not passed' do
      before do
        create_list :twilio_log, 24, twilio_status: :delivered
        create_list :twilio_log, 1, twilio_status: :undelivered
      end

      it { is_expected.to be false }
    end
  end
end
