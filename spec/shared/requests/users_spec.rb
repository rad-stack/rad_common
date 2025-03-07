require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create :user }
  let(:another) { create :user }
  let(:invalid_attributes) { { first_name: nil } }
  let(:new_name) { 'Obscure First Name' }
  let(:security_role) { create :security_role }
  let(:new_attributes) { { first_name: new_name, security_roles: [security_role.id.to_s] } }

  before { login_as signed_in_user, scope: :user }

  context 'when non-admin' do
    let(:signed_in_user) { create :user }
    let(:user) { signed_in_user }

    before { signed_in_user.security_roles.first.update! manage_user: true }

    describe 'PUT update' do
      it 'can update themselves but not their security roles' do
        put "/users/#{user.id}", params: { user: new_attributes }
        user.reload
        expect(user.first_name).to eq(new_name)
        expect(user.security_role_ids).not_to include security_role.id
      end
    end

    describe 'PUT update_timezone' do
      let(:existing_timezone) { 'Eastern Time (US & Canada)' }
      let(:new_timezone) { 'Pacific Time (US & Canada)' }

      before { user.update! timezone: existing_timezone, detected_timezone: new_timezone }

      it 'updates' do
        expect { put "/users/#{user.id}/update_timezone" }
          .to change { user.reload.timezone }.from(existing_timezone).to(new_timezone)
      end
    end
  end

  context 'when admin' do
    let(:signed_in_user) { create :admin }

    describe 'POST create' do
      before { allow(RadConfig).to receive(:manually_create_users?).and_return true }

      describe 'with valid params' do
        let(:valid_attributes) do
          { first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            mobile_phone: create(:phone_number, :mobile),
            password: 'cOmpl3x_p@55w0rd',
            email: 'example000@example.com' }
        end

        it 'creates the user and redirects' do
          post '/users', params: { user: valid_attributes }
          new_user = User.last
          expect(new_user.first_name).to eq(valid_attributes[:first_name])
          expect(response).to redirect_to(new_user)
        end
      end

      describe 'with invalid params' do
        it 're-renders the new template' do
          post '/users', params: { user: invalid_attributes }
          expect(response.body).to include 'Please review the problems below'
        end
      end
    end

    describe 'PUT update' do
      let(:valid_attributes) { { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name } }

      describe 'with valid params' do
        it 'updates the requested user' do
          put "/users/#{user.id}", params: { user: new_attributes }
          user.reload
          expect(user.first_name).to eq(new_name)
          expect(user.security_role_ids).to include security_role.id
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

      it 'can not delete if user created audits', :non_react_specs do
        another
        Audited::Audit.as_user(another) { user.update!(first_name: 'Foo') }
        expect(another.other_audits_created.count.positive?).to be true

        expect {
          delete "/users/#{another.id}", headers: { HTTP_REFERER: users_path }
        }.not_to change(User, :count)

        follow_redirect!
        expect(flash[:error]).to include 'User has audit history'
      end
    end

    describe 'export' do
      it 'exports' do
        get '/users/export', params: { format: :pdf }
        expect(response).to have_http_status :redirect
        expect(flash[:notice]).to include 'Your report is generating'
      end
    end
  end
end
