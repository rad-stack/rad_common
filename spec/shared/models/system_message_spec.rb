require 'rails_helper'

RSpec.describe SystemMessage, type: :model do
  let(:user) { create :admin }
  let(:message) { 'foo bar yo' }

  describe '#send!' do
    context 'with email message' do
      subject { mail.body.encoded }

      let(:system_message) { create :system_message, :email, user: user, email_message_body: message }
      let(:mail) { ActionMailer::Base.deliveries.last }

      before do
        ActionMailer::Base.deliveries = []
        system_message.send!
      end

      it { is_expected.to include message }
    end

    context 'with sms message' do
      subject { mail&.body&.encoded }

      let(:system_message) { create :system_message, :sms, user: user, sms_message_body: message }
      let(:mail) { ActionMailer::Base.deliveries.last }

      before do
        User.update_all(mobile_phone: create(:phone_number, :mobile))
        allow_any_instance_of(RadTwilio).to receive(:send_sms).and_return true
        ActionMailer::Base.deliveries = []
        system_message.send! if RadTwilio.new.twilio_enabled?
      end

      context 'when all users receive message' do
        it { is_expected.to be_nil }
      end
    end
  end
end
