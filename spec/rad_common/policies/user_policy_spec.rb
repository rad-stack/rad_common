require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  describe 'impersonate permissions', :impersonate_specs do
    subject { described_class }

    let(:admin) { create :admin }
    let(:user) { create :user }
    let(:client_user) { create :user, :external }

    permissions :impersonate? do
      context 'with admin' do
        it { is_expected.to permit(admin, User.new) }
      end

      context 'with user' do
        it { is_expected.not_to permit(user, User.new) }
      end

      context 'with client user' do
        it { is_expected.to permit(admin, client_user) }
      end
    end
  end
end
