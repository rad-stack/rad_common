require 'rails_helper'

RSpec.describe SystemMessage, type: :model do
  let!(:user) { create :admin }
  let(:message) { 'foo bar yo' }
  let(:system_message) { create :system_message, user: user, message: message, message_type: message_type }

  describe '#send!' do
    context 'email message' do
      subject { mail.body.encoded }

      before do
        ActionMailer::Base.deliveries = []
        system_message.send!
      end

      let(:message_type) { 'email' }
      let(:mail) { ActionMailer::Base.deliveries.last }

      it { is_expected.to include message }
    end

    context 'sms message' do
      subject { mail&.body&.encoded }

      let(:message_type) { 'sms' }

      before do
        User.update_all(mobile_phone: '(555) - 555 - 5555')
        allow(RadicalTwilio).to receive(:send_sms).and_return true
        ActionMailer::Base.deliveries = []
        system_message.send!
      end

      let(:mail) { ActionMailer::Base.deliveries.last }

      context 'all users receive message' do
        it { is_expected.to be_nil }
      end

      context 'a user does not receive message because mobile mumber is not present' do
        # apps that have mobile_phone configured as non-nullable will fail here, just remove the test
        let!(:other_user) { create :user, mobile_phone: nil }

        before { system_message.send! }

        it { is_expected.to include "These users did not receive a system SMS message because a mobile number was not present: #{other_user.id}" }
      end
    end
  end
end
