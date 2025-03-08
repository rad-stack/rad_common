require 'rails_helper'

RSpec.describe 'Users', type: :system do
  include ActionView::Helpers::DateHelper

  let(:user_status) { UserStatus.default_active_status }
  let(:pending_status) { UserStatus.default_pending_status }
  let(:user) { create :user, user_status: user_status }
  let(:admin) { create :admin }
  let(:password) { 'cOmpl3x_p@55w0rd' }
  let(:external_user) { create :user, :external }
  let(:client_user) { create :client_user }

  describe 'user' do
    before { login_as user, scope: :user }

    describe 'index' do
      let!(:pending_user) { create :user, user_status: pending_status }

      before { visit users_path }

      it 'shows users and limited info' do
        expect(page).to have_content 'Users (1)'
        expect(page).to have_content user.to_s
        expect(page).not_to have_content user.security_roles.first.name
        expect(page).not_to have_content 'Created'
        expect(page).not_to have_content 'Export to File'
      end

      it "doesn't show pending users" do
        visit users_path
        expect(page).not_to have_content pending_user.to_s
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
        expect(find_field('First name').value).to eq user.first_name
        new_name = Faker::Name.first_name
        fill_in 'First name', with: new_name
        fill_in 'Current password', with: password
        click_button 'Save'
        user.reload
        expect(user.first_name).to eq new_name
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
      let!(:pending_user) { create :user, user_status: pending_status }

      before { external_user.update! user_status: user.user_status if RadConfig.external_users? }

      it 'shows users and all info' do
        visit users_path
        expect(page).to have_content result_label
        expect(page).to have_content user.to_s
        expect(page).to have_content user.security_roles.first.name
        expect(page).to have_content 'Created'
        expect(page).to have_content 'Export to File'
        expect(page).to have_content external_user.to_s if RadConfig.external_users?
      end

      it 'shows pending users' do
        visit users_path
        expect(page).to have_content pending_user.to_s
      end

      it 'filters by user type', external_user_specs: true do
        external_user.update!(user_status: user.user_status)
        visit users_path(search: { user_status_id: user.user_status_id, external: 'external' })
        expect(page).not_to have_content user.email
        expect(page).to have_content external_user.email
      end
    end

    describe 'new' do
      let(:security_role) { create :security_role }

      before do
        allow(RadConfig).to receive(:disable_sign_up?).and_return true
        allow(RadConfig).to receive(:disable_invite?).and_return true
      end

      it 'renders the new template' do
        visit new_user_path
        expect(page).to have_content('New User')
      end
    end

    it 'updates the user' do
      visit edit_user_path(admin)
      new = 'foo'
      fill_in 'First name', with: new
      click_button 'Save'
      expect(page).to have_content new
    end

    describe 'show' do
      before { visit user_path(user) }

      it 'shows the user' do
        expect(page).to have_content user.to_s
      end

      it 'shows external user', external_user_specs: true do
        visit user_path(external_user)
        expect(page).to have_content external_user.first_name
      end

      it 'shows external user with client', user_client_specs: true do
        visit user_path(client_user)
        expect(page).to have_content client_user.first_name
      end

      it 'shows field names in title case' do
        expect(page).to have_content 'User Status'
      end

      it 'allows updating notification settings', :gha_specs_only, :js do
        expect(page).to have_content 'Notification Settings'
        uncheck 'Enabled'
        wait_for_ajax
        expect(notification_setting.enabled).to be false
      end
    end

    describe 'confirm' do
      before do
        user.update! confirmed_at: nil
        visit user_path(user)
      end

      it 'can manually confirm a user', :gha_specs_only, :js, :user_confirmable_specs do
        page.accept_confirm do
          click_link 'Confirm Email'
        end

        expect(page).to have_content 'User was successfully confirmed'
      end
    end

    describe 'reactivate', user_expirable_specs: true do
      let(:user) { create(:user, last_activity_at: last_activity_at) }

      before do
        visit user_path(user)
      end

      context 'when user is expired' do
        let(:last_activity_at) { (Devise.expire_after + 1.day).ago }

        it 'allows manual reactivation of the user', :gha_specs_only, :js do
          expect(page).to have_content("User's account has been expired due to inactivity")
          page.accept_confirm do
            click_link 'click here'
          end

          expect(page).to have_content 'User was successfully reactivated'
          expect(user.reload.last_activity_at).to be_nil
        end
      end

      context 'when user is not expired' do
        let(:last_activity_at) { (Devise.expire_after - 1.day).ago }

        it 'does not display reactivate option' do
          expect(page).not_to have_content("User's account has been expired due to inactivity")
        end
      end
    end
  end

  describe 'external user', external_user_specs: true do
    before do
      login_as(external_user, scope: :user)
    end

    describe 'show' do
      it 'does not allow' do
        expect { visit user_path(user) }.to raise_error ActionController::RoutingError
      end
    end

    describe 'index' do
      it 'does not allow' do
        expect { visit users_path }.to raise_error ActionController::RoutingError
      end
    end
  end

  describe 'sign up', :gha_specs_only, :js, :sign_up_specs do
    before do
      create :security_role, :external, allow_sign_up: true
      allow_any_instance_of(User).to receive(:twilio_verify_enabled?).and_return false
    end

    it 'signs up' do
      visit new_user_registration_path

      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Mobile phone', with: '(345) 222-1111'
      fill_in 'Email', with: "#{Faker::Internet.user_name}@abc.com"
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      expect(find_button('Sign Up', disabled: true).disabled?).to be(true)
      check 'accept_terms'

      click_button 'Sign Up'
      expect(page).to have_content 'message with a confirmation link has been sent'
    end

    it "can't sign up with invalid email address" do
      visit new_user_registration_path

      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'test_user@'
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      check 'accept_terms'

      click_button 'Sign Up'

      expect(page).to have_content 'Email is invalid'
    end
  end

  describe 'sign in' do
    it 'can not sign in without active user status' do
      user.update!(user_status: pending_status)

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

    it 'cannot sign in with expired password' do
      if Devise.mappings[:user].password_expirable?
        current_password = password
        new_password = 'Passwords2!!!!!'

        user.update(password_changed_at: 98.days.ago)
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
    end

    it 'cannot sign in when expired', user_expirable_specs: true do
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

    it 'sign in times out after 3 hours' do
      if Devise.mappings[:user].timeoutable?
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: password
        click_button 'Sign In'
        expect(page).to have_content('Signed in successfully')

        Timecop.travel(185.minutes.from_now) do
          visit users_path
          expect(page).to have_content('Your session expired. Please sign in again to continue.')
        end
      end
    end
  end

  describe 'edit' do
    before { login_as admin, scope: :user }

    it 'renders the edit template' do
      visit edit_user_path(user)
      expect(page).to have_content('Editing User')
    end

    it "doesn't update roles if user isn't valid" do
      security_role = create :security_role
      expect(user.security_roles.count).to eq 1

      visit edit_user_path(user)
      fill_in 'Last name', with: ''
      check security_role.name
      click_button 'Save'

      user.reload
      expect(user.security_roles.count).to eq 1

      fill_in 'Last name', with: 'Foo'
      click_button 'Save'

      user.reload
      expect(user.security_roles.count).to eq 2
    end
  end

  describe 'devise paranoid setting', devise_paranoid_specs: true do
    it 'wrong password - does not specify if email or password is wrong' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      click_button 'Sign In'
      expect(page).to have_content('Invalid Email or password.')
    end

    describe 'confirming' do
      let(:user) { create(:user, confirmed_at: nil) }

      let(:message) do
        'If your email address exists in our database, you will receive an email with instructions for how to ' \
          'confirm your email address in a few minutes.'
      end

      it "doesn't say whether the email exists", user_confirmable_specs: true do
        visit new_user_session_path

        click_link "Didn't Receive Confirmation Instructions?"
        fill_in 'Email', with: user.email
        click_button 'Resend Confirmation Instructions'

        expect(page).not_to have_content 'not found'
        expect(page).to have_content message
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    describe 'unlock' do
      let(:user) { create(:user, confirmed_at: nil) }

      let(:message) do
        'If your account exists, you will receive an email with instructions for how to unlock it in a few minutes.'
      end

      it "doesn't say whether the email exists" do
        visit new_user_session_path
        click_link "Didn't Receive Unlock Instructions?"

        fill_in 'Email', with: user.email
        click_button 'Resend Unlock Instructions'

        expect(page).not_to have_content 'not found'
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

        expect(page).not_to have_content 'not found'
        expect(page).to have_content message
      end
    end
  end

  describe 'authenticated admin' do
    let(:user) { create :admin }

    before { login_as user, scope: :user }

    describe 'update' do
      it 'updates Twilio when updating an accounts mobile phone', vcr: true do
        visit edit_user_registration_path
        fill_in 'user_mobile_phone', with: create(:phone_number, :mobile)
        fill_in 'user_current_password', with: password
        click_button 'Save'
        expect(page).to have_content('Your account has been updated successfully.')
      end
    end
  end
end
