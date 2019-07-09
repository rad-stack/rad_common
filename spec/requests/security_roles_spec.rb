require 'rails_helper'

RSpec.describe 'Security roles', type: :request do
  let(:user) { create :admin }
  let(:security_role) { create :security_role }

  before do
    login_as(user, scope: :user)
  end

  let(:valid_attributes) do
    { name: 'foo', read_audit: true }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new SecurityRole' do
        expect {
          post '/security_roles', params: { security_role: valid_attributes }
        }.to change(SecurityRole, :count).by(1)
      end

      it 'redirects to the created security_role' do
        post '/security_roles', params: { security_role: valid_attributes }
        expect(response).to redirect_to(SecurityRole.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/security_roles', params: { security_role: invalid_attributes }
        expect(response).not_to redirect_to(SecurityRole.last)
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { name: 'bar' }
      end

      it 'updates the requested security_role' do
        put "/security_roles/#{security_role.id}", params: { security_role: new_attributes }
        security_role.reload
        expect(security_role.name).to eq('bar')
      end

      it 'redirects to the security_role' do
        put "/security_roles/#{security_role.id}", params: { security_role: valid_attributes }
        expect(response).to redirect_to(security_role)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/security_roles/#{security_role.id}", params: { security_role: invalid_attributes }
        expect(response).not_to redirect_to(security_role)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested security_role' do
      security_role
      expect {
        delete :"/security_roles/#{security_role.id}", headers: { HTTP_REFERER: security_role_path(security_role) }
      }.to change(SecurityRole, :count).by(-1)
    end

    it 'redirects to the security_roles list' do
      delete "/security_roles/#{security_role.id}", headers: { HTTP_REFERER: security_role_path(security_role) }
      expect(response).to redirect_to(security_roles_url)
    end
  end
end
