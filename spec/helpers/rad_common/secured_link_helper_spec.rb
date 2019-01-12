require 'rails_helper'

describe RadCommon::SecuredLinkHelper do
  let(:user) { create :user }
  let!(:super_admin) { create :super_admin }
  let(:admin_security_role) { SecurityRole.find_by(name: 'Admin') }

  describe '#link_authorized?' do
    context 'user' do
      it 'authorizes users' do
        user_authorized = link_authorized?(super_admin, admin_security_role)
        expect(user_authorized).to eq(true)
      end

      it 'rejects unauthorized users' do
        user_authorized = link_authorized?(user, admin_security_role)
        expect(user_authorized).to eq(false)
      end
    end
  end
end
