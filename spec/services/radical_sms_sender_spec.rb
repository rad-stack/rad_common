require 'rails_helper'

RSpec.describe RadicalSMSSender, type: :service do
  let(:user) { create :user }
  let(:message) { 'test message' }
  let(:media_url) { nil }
  let(:sms_sender) { described_class.new(message, user.id, media_url) }

  before do
    allow(RadicalTwilio).to receive(:send_sms).and_return(nil)
    allow(RadicalTwilio).to receive(:send_mms).and_return(nil)
  end

  subject { sms_sender.send! }

  it { is_expected.to be_nil }
end
