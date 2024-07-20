require 'rails_helper'

RSpec.describe ContactLogRecipient do
  let(:admin) { create :admin, security_roles: [admin_role] }
  let(:admin_role) { create :security_role, :admin }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:last_email) { deliveries.last }

  before { deliveries.clear }

  describe 'notify!' do
    context 'with email' do
      let(:contact_log) { create :contact_log, :email }

      let(:contact_log_recipient) do
        create :contact_log_recipient, :email, contact_log: contact_log, email: admin.email, to_user: admin
      end

      it 'raises error when no admins to notify' do
        expect { contact_log_recipient.update! email_status: :bounce }.to raise_error('no users to notify')
      end

      context 'when another admin exists' do
        let!(:another_admin) { create :admin, security_roles: [admin_role] }

        it 'excludes the admin in the notification' do
          expect {
            contact_log_recipient.update! email_status: :bounce
          }.to change(deliveries, :count).by(1)

          expect(last_email.subject).to include 'Outgoing Email Failed for'
          expect(last_email.to).not_to include admin.email
          expect(last_email.to).to include another_admin.email
        end
      end
    end

    context 'with SMS' do
      let(:contact_log) { create :contact_log, :sms }

      let(:contact_log_recipient) do
        create :contact_log_recipient, contact_log: contact_log, phone_number: admin.mobile_phone, to_user: admin
      end

      before { create :admin, security_roles: [admin_role] }

      it 'notifies' do
        expect {
          contact_log_recipient.sms_assume_failed!
        }.to change(deliveries, :count).by(1)

        expect(last_email.subject).to include 'Outgoing SMS Failed for'
      end
    end
  end

  describe 'sms_false_positive?' do
    subject { contact_log_recipient.send(:sms_false_positive?) }

    let(:contact_log) { create :contact_log, :sms }

    let(:contact_log_recipient) do
      create :contact_log_recipient, contact_log: contact_log, phone_number: admin.mobile_phone, to_user: admin
    end

    it { is_expected.to be false }

    context 'with only a few recent logs' do
      before do
        4.times do
          create :contact_log_recipient,
                 contact_log: create(:contact_log, :sms),
                 phone_number: admin.mobile_phone,
                 to_user: admin,
                 sms_status: :delivered,
                 success: true
        end
      end

      it { is_expected.to be false }

      it 'has just a few recent sms logs' do
        expect(contact_log_recipient.send(:just_a_few_sms_logs?)).to be true
      end
    end
  end
end
