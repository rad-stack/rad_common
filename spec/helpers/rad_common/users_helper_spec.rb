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
    let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

    before do
      user
      another_user
    end

    it 'returns users' do
      expect(helper.user_grouped_collection(nil)).to eq result
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
  end
end
