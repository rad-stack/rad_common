require 'rails_helper'

RSpec.describe UserSecurityRole, type: :model do
  describe 'validate' do
    let(:user) { create :user }
    let(:security_role) { create :security_role }
    let(:user_security_role) { build :user_security_role, user: user, security_role: security_role }

    it 'is valid' do
      expect(user_security_role).to be_valid
    end
  end
end
