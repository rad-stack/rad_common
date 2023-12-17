require 'rails_helper'

describe RadCommon::UsersHelper do
  let(:current_user) { create :admin }

  before do
    allow_any_instance_of(User).to receive(:twilio_verify_enabled?).and_return(false)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe 'user_grouped_collection' do
    let(:user) { create :user, first_name: 'Allan' }
    let(:another_user) { create :user, first_name: 'Bobby' }
    let(:inactive_user) { create :user, :inactive }

    before do
      user
      another_user
      inactive_user
    end

    context 'with standard case' do
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

      it 'returns users' do
        expect(helper.user_grouped_collection(nil)).to eq result
      end
    end

    context 'with scope' do
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

      it 'returns users' do
        expect(helper.user_grouped_collection(nil, scopes: [:with_mobile_phone])).to eq result
      end
    end

    context 'with scope without another user' do
      let(:another_user) { create :user, mobile_phone: nil }
      let(:result) { [['Me', [current_user]], ['Users', [user]]] }

      it 'returns users' do
        expect(helper.user_grouped_collection(nil, scopes: [:with_mobile_phone])).to eq result
      end
    end

    context 'with scope without me' do
      let(:current_user) { create :user, mobile_phone: nil }
      let(:result) { [['Users', [user, another_user]]] }

      it 'returns users' do
        expect(helper.user_grouped_collection(nil, scopes: [:with_mobile_phone])).to eq result
      end
    end

    context 'with always include' do
      context 'with active user' do
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

        it 'returns users' do
          expect(helper.user_grouped_collection(user)).to eq result
        end
      end

      context 'with inactive user' do
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

        it 'returns users' do
          expect(helper.user_grouped_collection(inactive_user)).to eq result
        end
      end

      context 'with active user not in scope' do
        let(:user) { create :user, first_name: 'Allan', mobile_phone: nil }
        let(:result) { [['Me', [current_user]], ['Users', [another_user]], ['Inactive', [user]]] }

        it 'returns users' do
          expect(helper.user_grouped_collection(user, scopes: [:with_mobile_phone])).to eq result
        end
      end

      context 'with inactive user not in scope' do
        let(:inactive_user) { create :user, :inactive, mobile_phone: nil }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

        it 'returns users' do
          expect(helper.user_grouped_collection(inactive_user, scopes: [:with_mobile_phone])).to eq result
        end
      end
    end
  end
end
