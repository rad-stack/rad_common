require 'rails_helper'

describe 'Users' do
  include ActionView::Helpers::DateHelper

  let!(:internal_role) { create :security_role }
  let!(:external_role) { create :security_role, :external }

  let(:user) { create :user, security_roles: [internal_role] }
  let(:admin) { create :admin }
  let(:password) { 'cOmpl3x_p@55w0rd' }

  describe 'edit' do
    before do
      login_as admin, scope: :user
      visit edit_user_path(user)
    end

    context 'when dynamically changing fields', js: true do
      it 'shows internal roles and hides others' do
        find_field('user_external').set(false)
        expect(page).to have_content 'Security Roles'
        expect(page).to have_content internal_role.name
      end

      it 'shows external roles and hides others' do
        find_field('user_external').set(true)
        expect(page).to have_content 'Security Roles'
        expect(page).to have_content external_role.name
      end
    end
  end

  describe 'two factor authentication' do
    let(:remember_message) do
      "Remember this device for #{distance_of_time_in_words(Devise.twilio_verify_remember_device)}"
    end

    before do
      allow(Rails.application.credentials)
        .to receive(:twilio_verify_service_sid)
        .and_return(Rails.application.credentials.twilio_alt_verify_service_sid)

      allow(Rails.application.credentials)
        .to receive(:twilio_account_sid)
        .and_return(Rails.application.credentials.twilio_alt_account_sid)

      allow(Rails.application.credentials)
        .to receive(:twilio_auth_token)
        .and_return(Rails.application.credentials.twilio_alt_auth_token)

      user.update!(twilio_verify_enabled: true, mobile_phone: create(:phone_number, :mobile))
    end

    it 'allows user to login with authentication token', :vcr do
      allow(TwilioVerifyService).to receive(:verify_sms_token).and_return(double(status: 'approved'))

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      expect(page).to have_content remember_message
      fill_in 'twilio-verify-token', with: '7721070'
      click_button 'Verify and Sign in'
      expect(page).to have_content 'Signed in successfully'
    end

    it 'does not allow user to login with invalid twilio verify token', :vcr do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      fill_in 'twilio-verify-token', with: '123456'
      click_button 'Verify and Sign in'
      expect(page).to have_content('The entered token is invalid')
    end
  end
end
