require 'rails_helper'

RSpec.describe RadicalSmsSender, type: :service do
  let(:user_1) { create :user }
  let(:user_2) { create :user }
  let(:user_3) { create :user }
  let(:message) { 'test message' }
  let(:recipients) { [user_1.id, user_2.id, user_3.id] }
  let(:current_user) { create :user }
  let(:media_url) { nil }
  let(:sms_sender) { described_class.new(message, recipients, current_user, media_url) }

  before do
    allow(RadicalTwilio).to receive(:send_sms).and_return(nil)
    allow(RadicalTwilio).to receive(:send_mms).and_return(nil)
  end

  context 'without errors' do
    subject { sms_sender.send! }

    it { is_expected.to be_nil }
  end

  context 'with errors' do
    subject { mail&.body&.encoded }

    let(:user_2) { create :user, mobile_phone: nil }
    let(:mail) { ActionMailer::Base.deliveries.last }

    before do
      ActionMailer::Base.deliveries = []
      sms_sender.send!
    end

    context 'with one error' do
      it { is_expected.to include user_2.to_s }
    end

    context 'with two errors' do
      let(:user_3) { create :user, mobile_phone: nil }

      it { is_expected.to include user_2.to_s }
      it { is_expected.to include user_3.to_s }
    end

    context 'with one recipient' do
      let(:recipients) { [user_2.id] }

      it { is_expected.to include user_2.to_s }
    end
  end
end
