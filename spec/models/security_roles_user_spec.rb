require 'rails_helper'

describe SecurityRolesUser, type: :model do
  describe 'validate' do
    let(:allow_external) { Rails.application.config.external_users }
    let(:security_role) { create :security_role, read_audit: true }
    let(:security_roles_user) { build :security_roles_user, user: user, security_role: security_role }

    context 'internal user' do
      let(:user) { create :user }

      it 'is valid' do
        expect(security_roles_user).to be_valid
      end
    end

    context 'external user' do
      let(:user) { create :user, external: allow_external }

      it 'is invalid' do
        if allow_external
          expect(security_roles_user).not_to be_valid
          expect(security_roles_user.errors.full_messages.to_s).to include 'User is not valid when external'
        end
      end
    end
  end
end
