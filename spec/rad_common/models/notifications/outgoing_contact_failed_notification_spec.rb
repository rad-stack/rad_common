require 'rails_helper'

RSpec.describe Notifications::OutgoingContactFailedNotification do
  let!(:admin) { create :admin }
  let(:to_user) { create :user }
  let(:contact_log) { create :contact_log, :email, from_user: from_user }
  let(:contact_log_recipient) { create :contact_log_recipient, :email, contact_log: contact_log, to_user: to_user }
  let(:notification_type) { described_class.main(contact_log_recipient) }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify!
      expect(mail.subject).to eq "Outgoing Email Failed for #{to_user} in #{RadConfig.app_name!}"
    end

    context 'with from_user' do
      let(:from_user) { create :user }

      it 'emails the from_user' do
        expect(mail.to).to include from_user.email
        expect(mail.to).not_to include admin.email
      end
    end

    context 'without from_user' do
      let(:from_user) { nil }

      it 'emails the admins' do
        expect(mail.to).to include admin.email
      end
    end
  end
end
