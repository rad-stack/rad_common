require 'rails_helper'

describe 'Users' do
  include ActionView::Helpers::DateHelper

  let!(:internal_role) { create :security_role }
  let!(:external_role) { create :security_role, :external }
  let(:user) { create :user, security_roles: [internal_role] }
  let(:admin) { create :admin }
  let(:password) { 'cOmpl3x_p@55w0rd' }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:first_email) { deliveries.first }

  before { Rails.cache.write('rate_limit:twilio_verify', 0, expires_in: 5.minutes) }

  describe 'edit' do
    before do
      login_as admin, scope: :user
      visit edit_user_path user
      deliveries.clear
    end

    context 'when user is an admin' do
      let(:user) { create :admin }

      it "doesn't allow changing email" do
        expect(find_field('user_email', disabled: true).value).to eq(user.email)
      end
    end

    context 'when user is not an admin' do
      context 'when dynamically changing fields', :js do
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

      it 'allows changing email' do
        fill_in 'user_email', with: "foo_#{user.email}"
        click_link_or_button 'Save'
        expect(page).to have_content 'User was successfully updated.'
        expect(first_email.subject).to include 'Confirmation instructions'
      end
    end
  end

  describe 'two factor authentication' do
    let(:remember_message) do
      "Remember this device for #{distance_of_time_in_words(Devise.twilio_verify_remember_device)}"
    end

    before do
      allow(Rails.application.credentials)
        .to receive_messages(twilio_verify_service_sid: Rails.application.credentials.twilio_alt_verify_service_sid,
                             twilio_account_sid: Rails.application.credentials.twilio_alt_account_sid,
                             twilio_auth_token: Rails.application.credentials.twilio_alt_auth_token)

      user.update!(otp_required_for_login: true, mobile_phone: create(:phone_number, :mobile))
    end

    it 'allows user to login with authentication token', :vcr do
      allow(TwilioVerifyService).to receive(:verify_sms_token).and_return(double(status: 'approved'))

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      expect(page).to have_content remember_message
      fill_in 'twilio-verify-token', with: '7721070'
      click_on 'Verify and Sign in'
      expect(page).to have_content 'Signed in successfully'
    end

    it 'does not allow user to login with invalid twilio verify token', :vcr do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      fill_in 'twilio-verify-token', with: '123456'
      click_on 'Verify and Sign in'
      expect(page).to have_content('The entered token is invalid')
    end
  end

  describe 'edit user registration' do
    before do
      login_as admin, scope: :user
      visit edit_user_registration_path
    end

    it "can change user's own email address" do
      visit edit_user_registration_path

      fill_in 'user_email', with: "new_#{admin.email}"
      fill_in 'Current Password', with: password
      click_on 'Save'

      expect(page).to have_content 'You updated your account successfully, but we need to verify your new email address'
    end
  end
end
