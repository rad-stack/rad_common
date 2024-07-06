require 'rails_helper'

RSpec.describe Notifications::OutgoingContactFailedNotification do
  let!(:admin) { create :admin }
  let(:from_user) { create :user }
  let(:to_user) { create :user }
  let(:contact_log) { create :contact_log, from_user: from_user }
  let(:contact_log_recipient) { create :contact_log_recipient, contact_log: contact_log, to_user: to_user }
  let(:notification_type) { described_class.main(contact_log_recipient) }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify!
    end

    it 'emails' do
      expect(mail.subject).to eq "Outgoing SMS Failed for #{to_user} in #{RadConfig.app_name!}"
      expect(mail.to).to include from_user.email
      expect(mail.to).to include admin.email
    end
  end
end
