require 'rails_helper'

RSpec.describe Notifications::InvalidDataWasFoundNotification, type: :model do
  let(:notification_type) { described_class.main({ error_count: 0, error_messages: [] }) }
  let(:mail) { ActionMailer::Base.deliveries.last }

  before { create :admin }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify!
    end

    it 'emails' do
      expect(mail.subject).to eq "Invalid data in #{RadConfig.app_name!}"
    end
  end
end
