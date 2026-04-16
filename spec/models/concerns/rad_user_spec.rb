require 'rails_helper'

RSpec.describe RadUser, type: :module do
  describe 'permission?' do
    subject { user.permission?(:delete_division) }

    let(:user) { create :user, security_roles: [security_role_1, security_role_2, security_role_3] }

    context 'when all roles permit' do
      let(:security_role_1) { create :security_role, delete_division: true }
      let(:security_role_2) { create :security_role, delete_division: true }
      let(:security_role_3) { create :security_role, delete_division: true }

      it { is_expected.to be true }
    end

    context 'when some roles permit' do
      let(:security_role_1) { create :security_role, delete_division: true }
      let(:security_role_2) { create :security_role, delete_division: false }
      let(:security_role_3) { create :security_role, delete_division: true }

      it { is_expected.to be true }
    end

    context 'when no roles permit' do
      let(:security_role_1) { create :security_role, delete_division: false }
      let(:security_role_2) { create :security_role, delete_division: false }
      let(:security_role_3) { create :security_role, delete_division: false }

      it { is_expected.to be false }
    end
  end

  describe 'stale?' do
    context 'with an inactive user' do
      let(:user) { create :user, user_status: UserStatus.default_inactive_status }

      it 'raises an error' do
        expect { user.stale? }.to raise_error('not applicable to inactive users')
      end
    end

    context 'with a pending user' do
      let(:user) { create :user, user_status: UserStatus.default_pending_status }

      context 'when created less than 60 days ago' do
        it 'is not stale' do
          expect(user.stale?).to be false
        end
      end

      context 'when created more than 60 days ago' do
        before { user.update! created_at: 61.days.ago }

        it 'is stale' do
          expect(user.stale?).to be true
        end
      end
    end

    context 'with an active user' do
      let(:user) { create :user }

      context 'when recently updated' do
        before { user.update! updated_at: 1.day.ago }

        it 'is not stale' do
          expect(user.stale?).to be false
        end
      end

      context 'when not updated in over 4 months' do
        before { user.update! created_at: 5.months.ago, updated_at: 5.months.ago }

        it 'is stale' do
          expect(user.stale?).to be true
        end
      end
    end
  end

  describe 'unknown permission' do
    let(:user) { create :user }
    let(:permission) { :foo_bar_bro_bruh }

    it 'raises an exception' do
      expect { user.permission?(permission) }.to raise_error 'missing permission column: foo_bar_bro_bruh'
    end
  end
end
