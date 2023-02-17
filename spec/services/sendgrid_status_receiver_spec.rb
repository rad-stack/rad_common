require 'rails_helper'

describe SendgridStatusReceiver, type: :service do
  let(:service) { described_class.new(content) }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:user) { create :user }

  let(:content) do
    { event: 'bounce',
      type: 'block',
      bounce_classification: 'Reputation',
      email: user.email,
      host_name: host_name }
  end

  before do
    create :admin
    deliveries.clear
  end

  context 'when internal' do
    let(:host_name) { RadicalConfig.host_name! }

    it 'notifies' do
      expect { service.process! }.to change(deliveries, :count).by(1)
    end

    context 'with stale user' do
      before { user.update! created_at: 6.months.ago, updated_at: 6.months.ago }

      it 'deactivates' do
        expect(user.active?).to be true
        service.process!
        user.reload
        expect(user.active?).to be false
      end
    end
  end

  context 'when forward' do
    let(:host_name) { 'example.com' }

    before { allow_any_instance_of(RadSendgridStatusReceiver).to receive(:forward!) }

    it 'forwards' do
      expect { service.process! }.not_to change(deliveries, :count)
    end
  end
end
