require 'rails_helper'

RSpec.describe Notifications::OutgoingContactFailedNotification do
  let!(:admin) { create :admin }
  let(:from_user) { create :user }
  let(:to_user) { create :user }
  let(:record) { nil }
  let(:contact_log) { create :contact_log, service_type, from_user: from_user, record: record }
  let(:notification_type) { described_class.main(contact_log_recipient) }
  let(:mail) { ActionMailer::Base.deliveries.last }
  let(:to_failed) { to_user.presence || contact_log_recipient.phone_number }

  let(:contact_log_recipient) do
    create :contact_log_recipient, service_type, contact_log: contact_log, to_user: to_user
  end

  before do
    ActionMailer::Base.deliveries = []
    notification_type.notify!
  end

  context 'with SMS contact' do
    let(:service_type) { :sms }

    before { expect(mail.subject).to eq "Outgoing SMS Failed for #{to_failed} in #{RadConfig.app_name!}" }

    describe 'absolute_user_ids' do
      subject { notification_type.absolute_user_ids.sort }

      context 'with from_user same as to_user' do
        let(:from_user) { to_user }

        it { is_expected.to eq [from_user.id] }
      end

      context 'with from_user different than to_user' do
        it { is_expected.to eq [from_user.id, to_user.id].sort }
      end

      context 'without to_user' do
        let(:to_user) { nil }

        it { is_expected.to eq [from_user.id] }
      end
    end
  end

  context 'with email contact' do
    let(:service_type) { :email }

    before { expect(mail.subject).to eq "Outgoing Email Failed for #{to_failed} in #{RadConfig.app_name!}" }

    describe 'absolute_user_ids' do
      it 'is the from_user' do
        expect(notification_type.absolute_user_ids).to eq [from_user.id]
      end
    end

    context 'with from_user' do
      it 'emails the from_user' do
        expect(mail.to).to include from_user.email
        expect(mail.to).not_to include admin.email
      end

      context 'when same as to_user' do
        let(:from_user) { to_user }

        it 'emails the admins' do
          expect(mail.to).not_to include from_user.email
          expect(mail.to).to include admin.email
        end

        it "doesn't include from_user" do
          expect(mail.text_part.body.to_s).to include(to_user.to_s).once
        end
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
end
