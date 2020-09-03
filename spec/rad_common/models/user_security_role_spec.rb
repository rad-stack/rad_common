require 'rails_helper'

describe UserSecurityRole, type: :model do
  describe 'validate' do
    let(:allow_external) { RadCommon.external_users }
    let(:security_role) { create :security_role }
    let(:user_security_role) { build :user_security_role, user: user, security_role: security_role }

    context 'with internal user' do
      let(:user) { create :user }

      it 'is valid' do
        expect(user_security_role).to be_valid
      end
    end
  end
end
