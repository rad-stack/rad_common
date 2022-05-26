require 'rails_helper'

RSpec.describe 'States', type: :request do
  let(:user) { create :admin }
  let(:state) { create :state, code: Faker::Address.unique.state_abbr, name: Faker::Address.unique.state }
  let(:valid_attributes) { { code: 'ZZ', name: 'Alaska' } }
  let(:invalid_attributes) { { code: 'ZZ', name: nil } }

  before { login_as user, scope: :user }

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new State' do
        expect {
          post '/states', params: { state: valid_attributes }
        }.to change(State, :count).by(1)
      end

      it 'redirects to the created state' do
        post '/states', params: { state: valid_attributes }
        expect(response).to redirect_to(State.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/states', params: { state: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'bar' } }

      it 'updates the requested state' do
        put "/states/#{state.to_param}", params: { state: new_attributes }
        state.reload
        expect(state.name).to eq('bar')
      end

      it 'redirects to the state' do
        put "/states/#{state.to_param}", params: { state: valid_attributes }
        expect(response).to redirect_to(state)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/states/#{state.to_param}", params: { state: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested state' do
      state
      expect {
        delete "/states/#{state.to_param}",
               headers: { HTTP_REFERER: "/states/#{state.to_param}" }
      }.to change(State, :count).by(-1)
    end

    it 'redirects to the states list' do
      delete "/states/#{state.to_param}",
             headers: { HTTP_REFERER: "/states/#{state.to_param}" }
      expect(response).to redirect_to(states_url)
    end
  end
end
