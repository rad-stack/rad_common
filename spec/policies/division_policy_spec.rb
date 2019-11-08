require 'rails_helper'

RSpec.describe DivisionPolicy, type: :policy do
  subject { described_class }

  let(:reader_role) { create :security_role, read_division: true }
  let(:creator_role) { create :security_role, read_division: true, create_division: true }
  let(:updator_role) { create :security_role, read_division: true, update_division: true }

  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:reader) { create :user }
  let(:creator) { create :user }
  let(:manager) { create :user }
  let(:updator) { create :user }

  before do
    reader.security_roles << reader_role
    creator.security_roles << creator_role
    updator.security_roles << updator_role
    manager.security_roles << creator_role
    manager.security_roles << updator_role
  end

  permissions :index?, :show? do
    it { is_expected.to permit(reader, Division.new) }
  end

  permissions :create? do
    context 'when admin' do
      it { is_expected.to permit(admin, Division.new) }
    end

    context 'when creator' do
      it { is_expected.to permit(creator, Division.new) }
    end

    context 'when manager' do
      it { is_expected.to permit(manager, Division.new) }
    end

    context 'when non-admins' do
      it { is_expected.not_to permit(user, Division.new) }
    end

    context 'when updator' do
      it { is_expected.not_to permit(updator, Division.new) }
    end
  end
end
