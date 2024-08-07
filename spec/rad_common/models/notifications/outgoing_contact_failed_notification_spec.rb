require 'rails_helper'

RSpec.describe Notifications::OutgoingContactFailedNotification do
  let!(:admin) { create :admin }
  let(:from_user) { create :user }
  let(:to_user) { create :user }
  let(:record) { nil }
  let(:contact_log) { create :contact_log, :email, from_user: from_user, record: record }
  let(:contact_log_recipient) { create :contact_log_recipient, :email, contact_log: contact_log, to_user: to_user }
  let(:notification_type) { described_class.main(contact_log_recipient) }
  let(:mail) { ActionMailer::Base.deliveries.last }

  before do
    ActionMailer::Base.deliveries = []
    notification_type.notify!
    expect(mail.subject).to eq "Outgoing Email Failed for #{to_user} in #{RadConfig.app_name!}"
  end

  context 'with from_user' do
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

  describe 'record' do
    context 'when different from to_user' do
      let(:record) { create :user }

      it 'includes record' do
        expect(mail.text_part.body.to_s).to include(to_user.to_s).once
        expect(mail.text_part.body.to_s).to include(record.to_s).once
      end
    end

    context 'when same as to_user' do
      let(:record) { to_user }

      it "doesn't include record" do
        expect(mail.text_part.body.to_s).to include(record.to_s).once
      end
    end
  end
end
