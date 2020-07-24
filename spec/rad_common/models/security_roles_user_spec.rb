require 'rails_helper'

describe SecurityRolesUser, type: :model do
  describe 'validate' do
    let(:allow_external) { RadCommon.external_users }
    let(:security_role) { create :security_role }
    let(:security_roles_user) { build :security_roles_user, user: user, security_role: security_role }

    context 'with internal user' do
      let(:user) { create :user }

      it 'is valid' do
        expect(security_roles_user).to be_valid
      end
    end
  end
end
