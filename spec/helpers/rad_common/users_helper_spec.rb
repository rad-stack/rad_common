require 'rails_helper'

describe RadCommon::UsersHelper do
  let(:current_user) { create :admin }

  before do
    allow_any_instance_of(User).to receive(:twilio_verify_enabled?).and_return(false)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe 'user_grouped_collection' do
    subject { helper.user_grouped_collection(always_include, scopes: scopes) }

    let(:user) { create :user, first_name: 'Allan' }
    let(:another_user) { create :user, first_name: 'Bobby' }
    let(:inactive_user) { create :user, :inactive }
    let(:always_include) { nil }
    let(:scopes) { [] }

    before do
      user
      another_user
      inactive_user
    end

    context 'with standard case' do
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

      it { is_expected.to eq result }
    end

    context 'with scope' do
      let(:scopes) { [:with_mobile_phone] }
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

      it { is_expected.to eq result }
    end

    context 'with scope without another user' do
      let(:scopes) { [:with_mobile_phone] }
      let(:another_user) { create :user, mobile_phone: nil }
      let(:result) { [['Me', [current_user]], ['Users', [user]]] }

      it { is_expected.to eq result }
    end

    context 'with scope without me' do
      let(:scopes) { [:with_mobile_phone] }
      let(:current_user) { create :user, mobile_phone: nil }
      let(:result) { [['Users', [user, another_user]]] }

      it { is_expected.to eq result }
    end

    context 'with always include' do
      context 'with active user' do
        let(:always_include) { user }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

        it { is_expected.to eq result }
      end

      context 'with inactive user' do
        let(:always_include) { inactive_user }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

        it { is_expected.to eq result }
      end

      context 'with active user not in scope' do
        let(:scopes) { [:with_mobile_phone] }
        let(:always_include) { user }
        let(:user) { create :user, first_name: 'Allan', mobile_phone: nil }
        let(:result) { [['Me', [current_user]], ['Users', [another_user]], ['Inactive', [user]]] }

        it { is_expected.to eq result }
      end

      context 'with inactive user not in scope' do
        let(:scopes) { [:with_mobile_phone] }
        let(:always_include) { inactive_user }
        let(:inactive_user) { create :user, :inactive, mobile_phone: nil }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

        it { is_expected.to eq result }
      end
    end
  end
end
