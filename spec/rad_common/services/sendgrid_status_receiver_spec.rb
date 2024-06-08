require 'rails_helper'

describe SendgridStatusReceiver, type: :service do
  let(:service) { described_class.new(content) }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:user) { create :user }
  let(:event_type) { 'bounce' }
  let(:contact_log) { create :contact_log, :email }
  let!(:contact_log_recipient) { create :contact_log_recipient, :email, contact_log: contact_log, email: user.email }

  let(:content) do
    { event: event_type,
      type: 'block',
      bounce_classification: 'Reputation',
      email: user.email,
      host_name: host_name,
      contact_log_id: contact_log.id }
  end

  before do
    create :admin
    deliveries.clear
  end

  context 'with matching host name' do
    let(:host_name) { RadConfig.host_name! }

    it 'notifies' do
      expect { service.process! }.to change(deliveries, :count).by(1)
    end

    it 'updates status of contact log' do
      expect {
        service.process!
        contact_log_recipient.reload
      }.to change(contact_log_recipient, :email_status).from('delivered').to('bounce')
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
  end

  context 'without matching host name' do
    let(:host_name) { 'example.com' }

    it 'ignores' do
      expect { service.process! }.not_to change(deliveries, :count)
    end
  end
end
