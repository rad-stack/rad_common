require 'rails_helper'

describe StalePendingUserCleaner, type: :service do
  let(:service) { described_class.new }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:pending_status) { UserStatus.default_pending_status }

  before do
    create :admin
    deliveries.clear
  end

  describe 'run' do
    context 'when there are stale pending users' do
      let!(:stale_pending_user) { create :user, user_status: pending_status, created_at: 61.days.ago }
      let!(:fresh_pending_user) { create :user, user_status: pending_status }
      let!(:active_user) { create :user }

      it 'deletes stale pending users' do
        expect { service.run }.to change(User, :count).by(-1)
        expect(User.find_by(id: stale_pending_user.id)).to be_nil
      end

      it 'does not delete fresh pending users' do
        service.run
        expect(User.find_by(id: fresh_pending_user.id)).to be_present
      end

      it 'does not delete active users' do
        service.run
        expect(User.find_by(id: active_user.id)).to be_present
      end

      it 'notifies admins for each deleted user' do
        service.run
        body = deliveries.last.body.encoded
        expect(deliveries.last.subject).to eq 'Stale Pending User Deleted'
        expect(body).to include stale_pending_user.to_s
        expect(body).to include stale_pending_user.email
      end
    end

    context 'when there are no stale pending users' do
      let!(:fresh_pending_user) { create :user, user_status: pending_status }

      it 'does not send a notification' do
        service.run
        expect(deliveries).to be_empty
      end
    end

    context 'when pending users is disabled' do
      before { allow(RadConfig).to receive(:pending_users?).and_return(false) }

      it 'does nothing' do
        expect { service.run }.not_to change(User, :count)
      end
    end
  end
end
