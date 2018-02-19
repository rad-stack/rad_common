require 'rails_helper'

describe 'Users', type: :request do
  let(:user) { create :user }
  let(:admin) { create :admin }

  describe 'authenticated' do
    describe 'user' do
      before(:each) do
        login_as(user, scope: :user)
      end

      describe 'index' do
        it 'should show users' do
          visit users_path
          expect(page).to have_content 'Access Denied'
        end
      end

      describe 'profile' do
        it 'should show edit page' do
          visit edit_user_registration_path
          expect(find_field('First name').value).to eq user.first_name
        end
      end
    end

    describe 'admin' do
      before(:each) do
        login_as(admin, scope: :user)
      end

      describe 'index' do
        it 'should show users' do
          visit users_path(status: user.user_status_id)
          expect(page).to have_content user.to_s
        end
      end

      describe 'show' do
        it 'should show the user' do
          visit user_path(user)
          expect(page).to have_content user.to_s
        end
      end
    end
  end

  describe 'sign up' do
    it 'should sign up' do
      visit new_user_registration_path

      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: Faker::Internet.user_name + '@mayo.edu'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      click_button 'Sign Up'
      expect(page.html).to include('message with a confirmation link has been sent')
    end
  end

  describe 'sign in' do
    it 'can not sign in without active user status' do
      user.update!(user_status: UserStatus.default_pending_status)

      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'

      click_button 'Sign In'
      expect(page.html).to include('Your account has not been approved by your administrator yet.')
    end

    it 'should sign in' do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'

      click_button 'Sign In'
      expect(page.html).to include('Signed in successfully.')
    end
  end
end
