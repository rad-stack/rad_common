require 'rails_helper'

describe SendgridStatusReceiver, type: :service do
  let(:service) { described_class.new(content) }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:user_role) { create :security_role, read_attorney: true }
  let(:user) { create :user, security_roles: [user_role] }
  let(:event_type) { 'bounce' }
  let(:contact_log) { create :contact_log, :email, record: create(:attorney), from_user: user }

  let!(:contact_log_recipient) do
    create :contact_log_recipient, :email, contact_log: contact_log, email: user.email, to_user: user
  end

  let(:last_email) { deliveries.last }
  let(:host_name) { RadConfig.host_name! }

  let(:content) do
    { event: event_type, type: 'block', email: user.email, host_name: host_name, contact_log_id: contact_log.id }
  end

  before do
    create :admin
    deliveries.clear
  end

  it 'notifies' do
    service.process!

    expect(last_email.subject).to include 'Outgoing Email Failed'
    expect(last_email.body.encoded).to include 'Attorney'
    expect(last_email.html_part.decoded).to include contact_log.content
  end

  it 'ignores when a contact log was previously deleted' do
    contact_log.destroy!
    expect(service.process!).to be_nil
  end

  describe 'email changed' do
    let(:last_contact_log) { ContactLog.last }

    let(:content) do
      { event: event_type,
        type: 'block',
        email: user.email,
        host_name: RadConfig.host_name!,
        contact_log_id: last_contact_log.id }
    end

    before { RadDeviseMailer.email_changed(user).deliver_now }

    it "doesn't notify on failure" do
      expect(last_contact_log.content).to eq 'Email Changed'

      deliveries.clear
      described_class.new(content).process!

      expect(last_email).to be_nil
    end
  end

  context 'with matching host name' do
    it 'notifies' do
      expect { service.process! }.to change(deliveries, :count).by(1)
    end

    it 'updates status of contact log' do
      expect {
        service.process!
        contact_log_recipient.reload
      }.to change(contact_log_recipient, :email_status).from('delivered').to('bounce')
    end

    context 'with more than one recipient with same email' do
      let(:error_message) { "multiple recipients with same email #{user.email} for contact log #{contact_log.id}" }

      before { create :contact_log_recipient, :email, contact_log: contact_log, email: user.email, email_type: :bcc }

      it 'raises an error when updating status of contact log' do
        expect { service.process! }.to raise_error error_message
      end
    end

    context 'with stale user' do
      before { user.update! created_at: 6.months.ago, updated_at: 6.months.ago }

      it 'deactivates' do
        expect(user.active?).to be true

        service.process!
        user.reload

        expect(user.active?).to be false
        expect(deliveries.count).to eq 1
        expect(last_email.subject).to eq 'User Deactivated'
      end

      context 'when contact log recipient is not associated with user' do
        let!(:contact_log_recipient) do
          create :contact_log_recipient, :email, contact_log: contact_log, email: user.email, to_user: create(:user)
        end

        it 'does not deactivate' do
          expect(user.active?).to be true

          service.process!
          user.reload

          expect(user.active?).to be true
        end
      end
    end

    context 'with expired user' do
      before { user.update_column :last_activity_at, 1.year.ago }

      it 'deactivates' do
        expect(user.active?).to be true

        service.process!
        user.reload

        expect(user.active?).to be false
        expect(deliveries.count).to eq 1
        expect(last_email.subject).to eq 'User Deactivated'
      end
    end

    context 'with spam report' do
      let(:event_type) { 'spamreport' }

      it 'deactivates' do
        expect(user.active?).to be true

        service.process!
        user.reload

        expect(user.active?).to be false
        expect(deliveries.count).to eq 1
        expect(last_email.subject).to eq 'User Deactivated'
      end
    end
  end

  context 'with missing host name' do
    let(:host_name) { nil }

    it 'ignores' do
      expect { service.process! }.not_to change(deliveries, :count)
    end
  end

  context 'with non-matching host name' do
    let(:host_name) { 'example.com' }

    before { allow_any_instance_of(RadSendgridStatusReceiver).to receive(:forward!) }

    it 'forwards' do
      expect { service.process! }.not_to change(deliveries, :count)
    end
  end
end
