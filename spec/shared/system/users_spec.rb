require 'rails_helper'

RSpec.describe 'Users', type: :system do
  include ActionView::Helpers::DateHelper

  let(:user_status) { UserStatus.default_active_status }
  let(:pending_status) { UserStatus.default_pending_status }
  let(:inactive_status) { UserStatus.default_inactive_status }
  let(:user) { create :user, user_status: user_status }
  let(:admin) { create :admin }
  let(:password) { 'cOmpl3x_p@55w0rd' }
  let(:external_user) { create :user, :external }
  let(:client_user) { create :client_user }

  before { Rails.cache.write('rate_limit:twilio_verify', 0, expires_in: 5.minutes) }

  describe 'user' do
    before { login_as user, scope: :user }

    describe 'index' do
      before do
        allow_any_instance_of(UserPolicy).to receive(:update?).and_return(false)
        visit users_path
      end

      it 'shows users and limited info' do
        expect(page).to have_content 'Users (1)'
        expect(page).to have_content user.to_s
        expect(page).to have_no_content user.security_roles.first.name
        expect(page).to have_no_content ApplicationController.helpers.format_date(user.created_at)

        if Pundit.policy!(user, user).export?
          expect(page).to have_content 'Export to File'
        else
          expect(page).to have_no_content 'Export to File'
        end
      end

      it "doesn't show pending users", :pending_user_specs do
        pending_user = create :user, user_status: pending_status
        visit users_path

        if Pundit.policy!(user, User.new).update?
          expect(page).to have_content pending_user.to_s
        else
          expect(page).to have_no_content pending_user.to_s
        end
      end
    end

    describe 'show' do
      before { visit user_path(user) }

      it 'denies access' do
        expect(page).to have_content 'Access Denied'
      end
    end

    describe 'registration' do
      it 'updates registration' do
        visit edit_user_registration_path
        expect(find_field('First Name').value).to eq user.first_name
        new_name = Faker::Name.first_name
        fill_in 'First Name', with: new_name
        fill_in 'Current Password', with: password
        click_button 'Save'
        user.reload
        expect(user.first_name).to eq new_name
      end

      context 'when switching languages' do
        before { allow(RadConfig).to receive(:switch_languages?).and_return true }

        it 'updates registration', :shared_database_specs do
          visit edit_user_registration_path
          expect(page).to have_content 'My Account'
          select 'Spanish', from: 'Language'
          fill_in 'Current Password', with: password
          click_button 'Save'
          expect(user.reload.language).to eq 'Spanish'
          expect(page).to have_content 'Mi Cuenta'
        end
      end
    end
  end

  describe 'admin' do
    let!(:notification_type) do
      Notifications::NewUserSignedUpNotification.create! security_roles: [user.security_roles.first]
    end

    let(:notification_setting) { NotificationSetting.find_by(user: user, notification_type: notification_type) }
    let(:external_user) { create :user, :external }

    before { login_as admin, scope: :user }

    describe 'index' do
      let(:result_label) { RadConfig.external_users? ? 'Users (2)' : 'Users (1)' }

      before { external_user.update! user_status: user.user_status if RadConfig.external_users? }

      it 'shows users and all info' do
        visit users_path
        expect(page).to have_content result_label
        expect(page).to have_content user.to_s
        expect(page).to have_content user.security_roles.first.name
        expect(page).to have_content user.mobile_phone

        if Pundit.policy!(admin, user).export?
          expect(page).to have_content 'Export to File'
        else
          expect(page).to have_no_content 'Export to File'
        end

        expect(page).to have_content external_user.to_s if RadConfig.external_users?
      end

      it 'shows pending users', :pending_user_specs do
        pending_user = create :user, user_status: pending_status
        visit users_path

        if Pundit.policy!(admin, User.new).update?
          expect(page).to have_content pending_user.to_s
        else
          expect(page).to have_no_content pending_user.to_s
        end
      end

      it 'filters by user type', :external_user_specs do
        external_user.update!(user_status: user.user_status)
        visit users_path(search: { user_status_id: user.user_status_id, external: 'external' })
        expect(page).to have_no_content user.email
        expect(page).to have_content external_user.email
      end
    end

    describe 'new' do
      let(:security_role) { create :security_role }

      before { allow(RadConfig).to receive(:manually_create_users?).and_return true }

      it 'renders the new template' do
        visit new_user_path
        expect(page).to have_content('New User')
      end
    end

    describe 'edit' do
      it 'renders the edit template' do
        visit edit_user_path(user)
        expect(page).to have_content('Editing User')
      end

      it 'updates the user' do
        visit edit_user_path(admin)
        new = 'foo'
        fill_in 'First Name', with: new
        click_button 'Save'
        expect(page).to have_content new
      end

      it "doesn't update roles if user isn't valid" do
        security_role = create :security_role
        expect(user.security_roles.count).to eq 1

        visit edit_user_path(user)
        fill_in 'Last Name', with: ''
        check security_role.name
        click_button 'Save'

        user.reload
        expect(user.security_roles.count).to eq 1

        fill_in 'Last Name', with: 'Foo'
        click_button 'Save'

        user.reload
        expect(user.security_roles.count).to eq 2
      end

      it 'requires mobile phone when twilio verify enabled', :shared_database_specs do
        allow(RadConfig).to receive_messages(twilio_verify_all_users?: false, require_mobile_phone?: false)

        visit edit_user_path(user)
        fill_in 'Mobile Phone', with: ''
        check 'Two Factor Auth'
        click_button 'Save'

        expect(page).to have_content 'Mobile phone is required'

        fill_in 'Mobile Phone', with: user.mobile_phone
        click_button 'Save'

        expect(page).to have_content 'User was successfully updated'
      end
    end

    describe 'show' do
      before { visit user_path(user) }

      it 'shows the user' do
        expect(page).to have_content user.to_s
      end

      it 'shows external user', :external_user_specs do
        visit user_path(external_user)
        expect(page).to have_content external_user.first_name
      end

      it 'shows external user with client', :user_client_specs do
        visit user_path(client_user)
        expect(page).to have_content client_user.first_name
      end

      it 'shows field names in title case' do
        expect(page).to have_content 'User Status'
      end

      it 'allows updating notification settings', :js, :legacy_asset_specs do
        expect(page).to have_content 'Notification Settings'
        uncheck 'Enabled'
        wait_for_ajax
        expect(notification_setting.enabled).to be false
      end
    end

    describe 'reactivate', :user_expirable_specs do
      let(:user) { create :user, last_activity_at: last_activity_at }

      before do
        visit user_path(user)
      end

      context 'when user is not expired' do
        let(:last_activity_at) { (Devise.expire_after - 1.day).ago }

        it 'does not display reactivate option' do
          expect(page).to have_no_content("User's account has been expired due to inactivity")
        end
      end
    end
  end

  describe 'external user', :external_user_specs do
    before do
      login_as(external_user, scope: :user)
    end

    describe 'show' do
      it 'does not allow' do
        visit user_path(user)
        expect(page.status_code).to eq 403
      end
    end

    describe 'index' do
      it 'does not allow' do
        visit users_path
        expect(page.status_code).to eq 403
      end
    end
  end

  describe 'sign in' do
    before { allow(RadConfig).to receive(:twilio_verify_enabled?).and_return false }

    it 'can not sign in without active user status' do
      user.update!(user_status: RadConfig.pending_users? ? pending_status : inactive_status)

      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password

      click_button 'Sign In'
      expect(page).to have_content 'Your account has not been approved by your administrator yet.'
    end

    it 'signs in' do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password

      click_button 'Sign In'
      expect(page).to have_content 'Signed in successfully.'
    end

    it 'does not allow with invalid email' do
      visit new_user_session_path
      fill_in 'user_email', with: "foo#{user.email}"
      fill_in 'user_password', with: password
      click_button 'Sign In'
      expect(page).to have_content 'Invalid Email or password'
    end

    it 'cannot sign in with expired password', :password_expirable_specs do
      current_password = password
      new_password = 'Passwords2!!!!!'

      user.update(password_changed_at: (RadConfig.config_item!(:expire_password_after_days) + 8).days.ago)
      user.reload

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: current_password
      click_button 'Sign In'
      expect(page).to have_content('Your password is expired.')

      fill_in 'user_password', with: new_password
      fill_in 'user_password_confirmation', with: new_password
      fill_in 'user_current_password', with: current_password
      click_button 'Change My Password'
      expect(page).to have_content 'Your new password is saved.'
    end

    it 'cannot sign in when expired', :user_expirable_specs do
      user.update!(last_activity_at: 98.days.ago)
      user.reload

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      expect(page).to have_content('Your account has expired due to inactivity')

      user.update!(last_activity_at: Time.current)

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password
      click_button 'Sign In'
      expect(page).to have_content('Signed in successfully')
    end
  end

  describe 'timeout', :devise_timeoutable_specs do
    before { allow(RadConfig).to receive(:twilio_verify_enabled?).and_return false }

    context 'with internal user' do
      it 'sign in times out after the configured hours' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: password
        click_button 'Sign In'
        expect(page).to have_content('Signed in successfully')

        Timecop.travel((RadConfig.timeout_hours!.hours + 5.minutes).from_now) do
          visit users_path
          expect(page).to have_content('Your session expired. Please sign in again to continue.')
        end
      end
    end

    context 'with external user', :external_user_specs do
      it 'sign in times out after 3 hours' do
        visit new_user_session_path
        fill_in 'user_email', with: external_user.email
        fill_in 'user_password', with: password

        if RadConfig.config_item(:portal).blank? # TODO: temp hack, see Task 9298
          click_button 'Sign In'
          expect(page).to have_content('Signed in successfully')

          Timecop.travel(185.minutes.from_now) do
            visit users_path
            expect(page).to have_content('Your session expired. Please sign in again to continue.')
          end
        end
      end
    end
  end

  describe 'devise paranoid setting' do
    it 'wrong password - does not specify if email or password is wrong' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      click_button 'Sign In'
      expect(page).to have_content('Invalid Email or password.')
    end

    describe 'confirming' do
      let(:user) { create :user, confirmed_at: nil }

      let(:message) do
        'If your email address exists in our database, you will receive an email with instructions for how to ' \
          'confirm your email address in a few minutes.'
      end

      it "doesn't say whether the email exists", :user_confirmable_specs do
        visit new_user_session_path

        click_link "Didn't Receive Confirmation Instructions?"
        fill_in 'Email', with: user.email
        click_button 'Resend Confirmation Instructions'

        expect(page).to have_no_content 'not found'
        expect(page).to have_content message
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    describe 'unlock' do
      let(:user) { create :user, confirmed_at: nil }

      let(:message) do
        'If your account exists, you will receive an email with instructions for how to unlock it in a few minutes.'
      end

      it "doesn't say whether the email exists" do
        visit new_user_session_path
        click_link "Didn't Receive Unlock Instructions?"

        fill_in 'Email', with: user.email
        click_button 'Resend Unlock Instructions'

        expect(page).to have_no_content 'not found'
        expect(page).to have_content message
      end
    end

    describe 'resetting password' do
      let(:message) do
        'If your email address exists in our database, you will receive a password recovery link at your email ' \
          'address in a few minutes.'
      end

      it "doesn't say whether the email exists" do
        visit new_user_session_path
        click_link 'Forgot Your Password?'

        fill_in 'Email', with: user.email
        click_button 'Send Me Reset Password Instructions'

        expect(page).to have_no_content 'not found'
        expect(page).to have_content message
      end
    end
  end

  describe 'two factor authentication', :twilio_verify_specs do
    let(:remember_message) do
      "Remember this device for #{distance_of_time_in_words(Devise.twilio_verify_remember_device)}"
    end

    before do
      allow(Rails.application.credentials)
        .to receive_messages(twilio_verify_service_sid: Rails.application.credentials.twilio_alt_verify_service_sid,
                             twilio_account_sid: Rails.application.credentials.twilio_alt_account_sid,
                             twilio_auth_token: Rails.application.credentials.twilio_alt_auth_token)

      allow(TwilioVerifyService).to receive(:send_sms_token).and_return(double(status: 'pending'))

      user.update!(twilio_verify_enabled: true, mobile_phone: create(:phone_number, :mobile))
    end

    it 'allows user to login with authentication token' do
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

    it 'does not allow user to login with invalid twilio verify token' do
      allow(TwilioVerifyService).to receive(:verify_sms_token).and_return(false)

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
