require 'rails_helper'

RSpec.describe DivisionPolicy, type: :policy do
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

  subject { described_class }

  permissions :create? do
    it 'authorizes admins' do
      expect(subject).to permit(admin, Division.new)
    end

    it 'authorizes creator' do
      expect(subject).to permit(creator, Division.new)
    end

    it 'authorizes manager' do
      expect(subject).to permit(manager, Division.new)
    end

    it 'denies non-admins' do
      expect(subject).not_to permit(user, Division.new)
    end

    it 'denies updator' do
      expect(subject).not_to permit(updator, Division.new)
    end
  end
end


