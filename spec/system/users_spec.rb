require 'rails_helper'

describe 'Users' do
  include ActionView::Helpers::DateHelper

  let!(:internal_role) { create :security_role }
  let!(:external_role) { create :security_role, :external }

  let(:user) { create :user, security_roles: [internal_role] }
  let(:admin) { create :admin }
  let(:password) { 'cOmpl3x_p@55w0rd' }

  before { Rails.cache.write('rate_limit:twilio_verify', 0, expires_in: 5.minutes) }

  describe 'sign up', :js do
    before do
      create :security_role, :external, allow_sign_up: true
      allow(RadConfig).to receive_messages(twilio_verify_all_users?: false, legal_docs?: true)
    end

    context 'with duplicate' do
      let!(:first_name) { Faker::Name.first_name }
      let!(:last_name) { Faker::Name.last_name }
      let!(:mobile_phone) { '(345) 222-1111' }

      before do
        admin
        allow(User).to receive(:score_upper_threshold).and_return(10)
        create :user, :external, first_name: first_name, last_name: last_name, mobile_phone: mobile_phone
      end

      it 'notifies admins but not the user signing up' do
        visit new_user_registration_path

        fill_in 'First Name', with: first_name
        fill_in 'Last Name', with: last_name
        fill_in 'Mobile Phone', with: mobile_phone
        fill_in 'Email', with: "#{Faker::Internet.user_name}@abc.com"
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password
        expect(find_button('Sign Up', disabled: true).disabled?).to be(true)
        check 'accept_terms'

        click_button 'Sign Up'
        expect(page).to have_content 'message with a confirmation link has been sent'

        ActionMailer::Base.deliveries.clear
        user = User.last
        user.process_duplicates
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(ActionMailer::Base.deliveries.last.subject).to include "Possible Duplicate User (#{user}) Signed Up"
      end
    end
  end

  describe 'edit' do
    before do
      login_as admin, scope: :user
      visit edit_user_path(user)
    end

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

  describe 'edit user registration' do
    before do
      login_as admin, scope: :user
      visit edit_user_registration_path
    end

    it "can change user's own email address" do
      visit edit_user_registration_path

      fill_in 'user_email', with: "new_#{admin.email}"
      fill_in 'Current Password', with: password
      click_button 'Save'

      expect(page).to have_content 'You updated your account successfully, but we need to verify your new email address'
    end
  end
end
