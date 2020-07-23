require 'rails_helper'

RSpec.describe SystemMessage, type: :model do
  let(:user) { create :admin }
  let(:message) { 'foo bar yo' }

  describe '#send!' do
    context 'email message' do
      subject { mail.body.encoded }

      let(:system_message) { create :system_message, :email, user: user, email_message_body: message }

      before do
        ActionMailer::Base.deliveries = []
        system_message.send!
      end

      let(:mail) { ActionMailer::Base.deliveries.last }

      it { is_expected.to include message }
    end

    context 'sms message' do
      subject { mail&.body&.encoded }

      let(:system_message) { create :system_message, :sms, user: user, sms_message_body: message }

      before do
        User.update_all(mobile_phone: Faker::PhoneNumber.cell_phone)
        allow(RadicalTwilio).to receive(:send_sms).and_return true
        ActionMailer::Base.deliveries = []
        system_message.send!
      end

      let(:mail) { ActionMailer::Base.deliveries.last }

      context 'all users receive message' do
        it { is_expected.to be_nil }
      end
    end
  end
end
