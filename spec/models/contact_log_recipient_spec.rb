require 'rails_helper'

RSpec.describe ContactLogRecipient do
  let(:admin) { create :admin, security_roles: [admin_role] }
  let(:admin_role) { create :security_role, :admin }
  let(:contact_log) { create :contact_log, :email }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:last_email) { deliveries.last }

  let(:contact_log_recipient) do
    create :contact_log_recipient, :email, contact_log: contact_log, email: admin.email, to_user: admin
  end

  before { deliveries.clear }

  describe 'maybe_notify' do
    it 'raises error when no admins to notify' do
      expect { contact_log_recipient.update! email_status: :bounce }.to raise_error('no users to notify')
    end

    context 'when another admin exists' do
      let!(:another_admin) { create :admin, security_roles: [admin_role] }

      it 'excludes the admin in the notification' do
        expect {
          contact_log_recipient.update! email_status: :bounce
        }.to change(deliveries, :count).by(1)

        expect(last_email.to).not_to include admin.email
        expect(last_email.to).to include another_admin.email
      end
    end
  end
end
