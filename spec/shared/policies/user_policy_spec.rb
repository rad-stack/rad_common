require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  describe 'impersonate permissions', :impersonate_specs do
    subject { described_class }

    let(:admin) { create :admin }
    let(:user) { create :user }
    let(:client_user) { create :user, :external }
    let(:another_user) { create :user }
    let(:inactive_user) { create :user, :inactive }

    permissions :impersonate? do
      context 'with admin' do
        it { is_expected.to permit(admin, user) }
      end

      context 'with user' do
        it { is_expected.not_to permit(user, another_user) }
      end

      context 'with client user' do
        it { is_expected.to permit(admin, client_user) }
      end

      context 'with same user' do
        it { is_expected.not_to permit(admin, admin) }
      end

      context 'with inactive user' do
        it { is_expected.not_to permit(admin, inactive_user) }
      end
    end
  end
end
