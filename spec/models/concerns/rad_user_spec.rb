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

  describe 'unknown permission' do
    let(:user) { create :user }
    let(:permission) { :foo_bar_bro_bruh }

    it 'raises an exception' do
      expect { user.permission?(permission) }.to raise_error 'missing permission column: foo_bar_bro_bruh'
    end
  end
end
