require 'rails_helper'

RSpec.describe SecurityRolesController, type: :controller do
  let(:user) { create :admin }
  let(:security_role) { create :security_role }

  before do
    sign_in user
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
          post :create, params: { security_role: valid_attributes }
        }.to change(SecurityRole, :count).by(1)
      end

      it 'redirects to the created security_role' do
        post :create, params: { security_role: valid_attributes }
        expect(response).to redirect_to(SecurityRole.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post :create, params: { security_role: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { name: 'bar' }
      end

      it 'updates the requested security_role' do
        put :update, params: { id: security_role.to_param, security_role: new_attributes }
        security_role.reload
        expect(security_role.name).to eq('bar')
      end

      it 'redirects to the security_role' do
        put :update, params: { id: security_role.to_param, security_role: valid_attributes }
        expect(response).to redirect_to(security_role)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put :update, params: { id: security_role.to_param, security_role: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @request.env['HTTP_REFERER'] = security_role_path(security_role)
    end

    it 'destroys the requested security_role' do
      security_role
      expect {
        delete :destroy, params: { id: security_role.to_param }
      }.to change(SecurityRole, :count).by(-1)
    end

    it 'redirects to the security_roles list' do
      delete :destroy, params: { id: security_role.to_param }
      expect(response).to redirect_to(security_roles_url)
    end
  end
end
