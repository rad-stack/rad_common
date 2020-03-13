require 'rails_helper'

describe 'Users', type: :system do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:password) { 'password' }

  describe 'two factor authentication' do
    let(:authy_id) { '1234567' }

    before do
      expect(Authy::API).to receive(:register_user).and_return(double(:response, ok?: true, id: authy_id))
      user.update!(authy_enabled: true, mobile_phone: '(904) 226-4901')
    end

    it 'allows user to login with authentication token' do
      expect(Authy::API).to receive(:verify).and_return(double(:response, ok?: true))

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      expect(page).to have_content 'Remember this device for 7 days'
      fill_in 'authy-token', with: '7721070'
      click_button 'Verify and Sign in'
      expect(page).to have_content 'Signed in successfully'
    end

    it 'does not allow user to login with invalid authy token' do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      fill_in 'authy-token', with: 'Not the authy token'
      click_button 'Verify and Sign in'
      expect(page).to have_content('The entered token is invalid')
    end

    it 'updates authy when updating an accounts mobile phone' do
      expect(Authy::API).to receive(:user_status).and_return(double(:response, ok?: false))
      expect(Authy::API).to receive(:register_user).and_return(double(:response, ok?: true, id: authy_id))

      login_as(user, scope: :user)
      visit edit_user_registration_path
      fill_in 'user_mobile_phone', with: '(345) 222-1111'
      fill_in 'user_current_password', with: password
      click_button 'Save'
      expect(page).to have_content('Your account has been updated successfully.')
    end
  end

  describe 'edit' do
    before do
      login_as admin, scope: :user
      visit edit_user_path(user)
    end

    context 'dynamically changing fields', js: true do
      it 'hides internal fields if client user is checked' do
        find_field('user_external').set(false)
        expect(page).to have_content 'Security roles'
      end

      it 'shows internal fields if client user is not checked' do
        find_field('user_external').set(true)
        expect(page).not_to have_content 'Security roles'
      end
    end
  end
end
