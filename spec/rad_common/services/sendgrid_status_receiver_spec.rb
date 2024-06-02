require 'rails_helper'

describe SendgridStatusReceiver, type: :service do
  let(:service) { described_class.new(content) }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:user) { create :user }
  let(:admin_role) { create :security_role, :admin }
  let!(:admin) { create :admin, security_roles: [admin_role] }
  let(:event_type) { 'bounce' }
  let(:last_email) { deliveries.last }
  let(:contact_log) { create :contact_log, :email }

  let(:contact_log_recipient) do
    create :contact_log_recipient, contact_log: contact_log, phone_number: nil, email: Faker::Internet.email
  end

  let(:content) do
    { event: event_type,
      type: 'block',
      bounce_classification: 'Reputation',
      email: user.email,
      host_name: host_name,
      contact_log_id: contact_log.id }
  end

  before { deliveries.clear }

  context 'with matching host name' do
    let(:host_name) { RadConfig.host_name! }

    it 'notifies' do
      expect { service.process! }.to change(deliveries, :count).by(1)
    end

    it 'updates status of contact log' do
      expect(contact_log_recipient.email_status).to be_nil
      service.process!
      contact_log_recipient.reload
      expect(contact_log_recipient.email_status).to eq 'bounce'
    end

    context 'with stale user' do
      before { user.update! created_at: 6.months.ago, updated_at: 6.months.ago }

      it 'deactivates' do
        expect(user.active?).to be true

        service.process!
        user.reload

        expect(user.active?).to be false
        expect(deliveries.count).to eq 0
      end
    end

    context 'with spam report' do
      let(:event_type) { 'spamreport' }

      it 'deactivates' do
        expect(user.active?).to be true

        service.process!
        user.reload

        expect(user.active?).to be false
        expect(deliveries.count).to eq 0
      end
    end

    context 'when admin is the failure' do
      let(:user) { admin }

      it 'excludes the admin in the notification' do
        # crashes when there are no admins to notify
        expect { service.process! }.to raise_error('no users to notify')

        # doesn't notify the failing user
        create :admin, security_roles: [admin_role]
        service.process!
        expect(deliveries.count).to eq 1
        expect(last_email.to).not_to include admin.email
      end
    end
  end

  context 'without matching host name' do
    let(:host_name) { 'example.com' }

    it 'ignores' do
      expect { service.process! }.not_to change(deliveries, :count)
    end
  end
end
