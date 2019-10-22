require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:another) { create :user }
  let(:valid_attributes) { { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name } }
  let(:invalid_attributes) { { first_name: nil } }

  before { login_as(admin, scope: :user) }

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_name) { 'Gary' }

      let(:new_attributes) do
        { first_name: new_name }
      end

      it 'updates the requested user' do
        put "/users/#{user.id}", params: { user: new_attributes }
        user.reload
        expect(user.first_name).to eq(new_name)
      end

      it 'redirects to the user' do
        put "/users/#{user.id}", params: { user: valid_attributes }
        expect(response).to redirect_to(user)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/users/#{user.id}", params: { user: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested user' do
      user
      expect {
        delete "/users/#{user.id}", headers: { HTTP_REFERER: user_path(user) }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete "/users/#{user.id}", headers: { HTTP_REFERER: user_path(user) }
      expect(response).to redirect_to(users_url)
    end

    it 'can not delete if user created audits' do
      Audited::Audit.as_user(another) do
        user.update!(first_name: 'Foo')
      end

      delete "/users/#{another.id}", headers: { HTTP_REFERER: users_path }
      follow_redirect!
      expect(response.body).to include 'User has audit history'
    end
  end

  describe 'audit_search' do
    let!(:search_user) { create :user }
    let!(:search_role) { create :security_role }

    context 'with audit' do
      it 'renders audit page' do
        get '/users/audit_search', params: { model_name: search_user.class.to_s, record_id: search_user.id }
        expect(response.body).to include "Updates for <a href=\"/users/#{search_user.id}\">User - Test User</a>"
      end
    end

    context 'without audit' do
      it 'does not render audit page' do
        get '/users/audit_search', params: { model_name: search_role.class.to_s, record_id: -1 }
        expect(response.body).not_to include "Updates for <a href=\"/users/#{search_user.id}\">User - Test User</a>"
      end
    end

    context 'without resource' do
      it 'does not render audit page' do
        get '/users/audit_search'
        expect(response.body).not_to include 'Audit for Foo with ID of 9999 not found'
        get '/users/audit_search', params: { model_name: 'Foo', record_id: 9999 }
        expect(response.body).to include 'Audit for Foo with ID of 9999 not found'
      end
    end
  end
end
