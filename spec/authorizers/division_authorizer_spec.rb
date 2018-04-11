require 'rails_helper'

RSpec.describe DivisionAuthorizer, type: :authorizer do
  let(:creator_role) { create :security_role, read_division: true, create_division: true }
  let(:updator_role) { create :security_role, read_division: true, update_division: true }

  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:creator) { create :user }
  let(:manager) { create :user }
  let(:updator) { create :user }

  before do
    creator.security_roles << creator_role
    updator.security_roles << updator_role
    manager.security_roles << creator_role
    manager.security_roles << updator_role
  end

  describe 'creatable' do
    it 'authorizes admins' do
      expect(admin.can_create?(Division)).to eq(true)
    end

    it 'authorizes creator' do
      expect(creator.can_create?(Division)).to eq(true)
    end

    it 'authorizes manager' do
      expect(manager.can_create?(Division)).to eq(true)
    end

    it 'denies non-admins' do
      expect(user.can_create?(Division)).to eq(false)
    end

    it 'denies updator' do
      expect(updator.can_create?(Division)).to eq(false)
    end
  end
end
