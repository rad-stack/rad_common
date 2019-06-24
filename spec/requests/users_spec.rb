require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:another) { create :user }

  before do
    login_as(admin, scope: :user)
  end

  let(:valid_attributes) do
    { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  end

  let(:invalid_attributes) do
    { first_name: nil }
  end

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
        expect(response).to render_template('edit')
      end

      describe 'confirm' do
        before do
          user.update! confirmed_at: nil
          visit user_path(user)
        end

        it 'can manually confirm a user', :js do
          accept_confirm do
            click_link 'Confirm Email'
          end

          expect(page.html).to include 'User was successfully confirmed'
        end
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

    context 'resource with audit' do
      it 'renders audit page' do
        get '/users/audit_search', params: { model_name: search_user.class.to_s, record_id: search_user.id }
        expect(response).to render_template('audits/index')
      end
    end

    context 'resource with no audit' do
      it 'does not render audit page' do
        get '/users/audit_search', params: { model_name: search_role.class.to_s, record_id: -1 }
        expect(response).not_to render_template('audits/index')
      end
    end

    context 'no resource' do
      it 'does not render audit page' do
        get '/users/audit_search'
        expect(response).not_to render_template('audits/index')
        get '/users/audit_search', params: { model_name: 'Foo', record_id: 9999 }
        expect(response).not_to render_template('audits/index')
      end
    end
  end
end
