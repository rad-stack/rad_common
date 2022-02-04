require 'rails_helper'

RSpec.describe 'UserClients', type: :request, user_client_specs: true do
  let(:admin) { create :admin }
  let(:user) { create :user, :external }
  let(:client_user) { create :client_user, client: client }
  let(:user_client) { client_user.user_clients.first }
  let(:client) { create :client }
  let(:valid_attributes) { { client_id: client.id, user_id: user.id } }
  let(:invalid_attributes) { { client_id: nil, user_id: client_user.id } }

  before { login_as admin, scope: :user }

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new UserClient' do
        expect {
          post '/user_clients/', params: { user_client: valid_attributes }
        }.to change(UserClient, :count).by(1)
      end

      it 'redirects to the user' do
        post '/user_clients/', params: { user_client: valid_attributes }
        expect(response).to redirect_to(UserClient.last.user)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/user_clients/', params: { user_client: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      create :user_client, user: user_client.user
    end

    it 'destroys the requested user_client' do
      user_client
      expect {
        delete "/user_clients/#{user_client.id}"
      }.to change(UserClient, :count).by(-1)
    end

    it 'redirects to the user' do
      delete "/user_clients/#{user_client.id}"
      expect(response).to redirect_to(user_client.user)
    end
  end
end
