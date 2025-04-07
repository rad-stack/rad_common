require 'rails_helper'

RSpec.describe 'Clients' do
  let(:user) { create :admin }
  let(:client) { create :client }
  let(:valid_attributes) { { name: 'foo', email: 'joe@abc.com' } }
  let(:invalid_attributes) { { name: nil, email: 'joe@abc.com' } }

  before { login_as user, scope: :user }

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Client' do
        expect {
          post '/clients', params: { client: valid_attributes }
        }.to change(Client, :count).by(1)
      end

      it 'redirects to the created client' do
        post '/clients', params: { client: valid_attributes }
        expect(response).to redirect_to(Client.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/clients', params: { client: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'bar' } }

      it 'updates the requested client' do
        put "/clients/#{client.to_param}", params: { client: new_attributes }
        client.reload
        expect(client.name).to eq('bar')
      end

      it 'redirects to the client' do
        put "/clients/#{client.to_param}", params: { client: valid_attributes }
        expect(response).to redirect_to(client)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/clients/#{client.to_param}", params: { client: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested client' do
      client
      expect {
        delete "/clients/#{client.to_param}",
               headers: { HTTP_REFERER: "/clients/#{client.to_param}" }
      }.to change(Client, :count).by(-1)
    end

    it 'redirects to the clients list' do
      delete "/clients/#{client.to_param}",
             headers: { HTTP_REFERER: "/clients/#{client.to_param}" }
      expect(response).to redirect_to(clients_url)
    end
  end
end
