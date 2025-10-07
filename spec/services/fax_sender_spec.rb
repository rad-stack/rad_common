require 'rails_helper'

RSpec.describe FaxSender, type: :service do
  let(:user) { create :user }
  let(:division) { create :division }
  let(:contact_log) do
    ContactLog.create_fax_log!(to_number: to_number, attachments: [file], from_user_id: user.id,
                               associated_record: division)
  end
  let(:file) { Rails.root.join('spec/fixtures/test.pdf').binread }
  let(:to_number) { SinchFaxClient::DEFAULT_TEST_NUMBER }
  let(:fax_sender) { described_class.new(contact_log) }

  before { allow(RadRetry).to receive(:exponential_pause) }

  describe 'send!', :vcr do
    let(:result) { fax_sender.send! }

    it 'sends fax' do
      expect(result).to be true
    end
  end
end
