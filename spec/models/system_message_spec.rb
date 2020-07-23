require 'rails_helper'

RSpec.describe SystemMessage, type: :model do
  let(:user) { create :admin }
  let(:message) { 'foo bar yo' }

  describe '#send!' do
    context 'with sms message' do
      subject { mail&.body&.encoded }

      let(:system_message) { create :system_message, :sms, user: user, sms_message_body: message }
      let(:mail) { ActionMailer::Base.deliveries.last }

      before do
        User.update_all(mobile_phone: Faker::PhoneNumber.cell_phone)
        allow(RadicalTwilio).to receive(:send_sms).and_return true
        ActionMailer::Base.deliveries = []
        system_message.send!
      end

      context 'when a user does not receive message because mobile mumber is not present' do
        let!(:other_user) { create :user, mobile_phone: nil }

        before { system_message.send! }

        it { is_expected.to include "These users did not receive a system SMS message because a mobile number was not present: #{other_user.id}" }
      end
    end
  end
end
