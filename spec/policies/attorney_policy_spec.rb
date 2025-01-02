require 'rails_helper'

RSpec.describe AttorneyPolicy, type: :policy do
  subject { described_class }

  let(:reader_role) { create :security_role, read_attorney: true }

  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:reader) { create :user }

  before { reader.security_roles << reader_role }

  permissions :index?, :show? do
    context 'when reader' do
      it { is_expected.to permit(reader, Attorney.new) }
    end

    context 'when non-admins' do
      it { is_expected.not_to permit(user, Attorney.new) }
    end
  end

  permissions :resolve_duplicates? do
    context 'when admin' do
      it { is_expected.to permit(admin, Attorney.new) }
    end

    context 'when reader' do
      it { is_expected.to permit(reader, Attorney.new) }
    end

    context 'when non-admins' do
      it { is_expected.not_to permit(user, Attorney.new) }
    end
  end
end
