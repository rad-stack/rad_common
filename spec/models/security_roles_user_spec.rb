require 'rails_helper'

describe SecurityRolesUser, type: :model do
  describe 'validate' do
    let(:security_roles_user) { build :security_roles_user, user: user }

    context 'internal user' do
      let(:user) { create :user }

      it 'is valid' do
        expect(security_roles_user).to be_valid
      end
    end

    context 'external user' do
      let(:user) { create :user, external: true }

      it 'is invalid' do
        expect(security_roles_user).not_to be_valid
        expect(security_roles_user.errors.full_messages.to_s).to include 'User is not valid when external'
      end
    end
  end
end
