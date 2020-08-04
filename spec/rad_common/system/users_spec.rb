require 'rails_helper'

describe 'Users', type: :system do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:password) { 'cOmpl3x_p@55w0rd' }
  let(:external_user) { create :user, :external }

  describe 'user' do
    before { login_as(user, scope: :user) }

    describe 'index' do
      it 'shows users' do
        visit users_path
        expect(page).to have_content 'Access Denied'
      end
    end

    describe 'profile' do
      it 'updates profile' do
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
      it 'shows users' do
        external_user.update! user_status: user.user_status
        visit users_path(search: { user_status_id: user.user_status_id })
        expect(page).to have_content user.to_s
        expect(page).to have_content external_user.to_s
      end

      it 'filters by user type' do
        if RadCommon.external_users
          external_user.update!(user_status: user.user_status)
          visit users_path(search: { user_status_id: user.user_status_id, external: 'external' })
          expect(page).not_to have_content user.email
          expect(page).to have_content external_user.email
        end
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

      it 'shows client user' do
        if RadCommon.external_users
          visit user_path(external_user)
          expect(page).to have_content admin.first_name
        end
      end

      it 'shows field names in title case' do
        expect(page).to have_content 'User Status'
      end

      it 'allows updating notification settings', :js do
        expect(page).to have_content 'Notification Settings'
        uncheck 'Enabled'
        sleep 2
        expect(notification_setting.enabled).to be false
      end
    end

    describe 'confirm' do
      before do
        user.update! confirmed_at: nil
        visit user_path(user)
      end

      it 'can manually confirm a user', :js do
        page.accept_confirm do
          click_link 'Confirm Email'
        end

        expect(page).to have_content 'User was successfully confirmed'
      end
    end
  end

  describe 'client user' do
    before { login_as external_user, scope: :user }

    describe 'show' do
      it 'does not allow' do
        if RadCommon.external_users
          if RadCommon.portal_namespace.present?
            expect { visit user_path(user) }.to raise_error ActionController::RoutingError
          else
            visit user_path(user)
            expect(page.status_code).to eq 403
            expect(page).to have_content 'Access Denied'
          end
        end
      end
    end

    describe 'index' do
      it 'does not allow' do
        if RadCommon.external_users
          if RadCommon.portal_namespace.present?
            expect { visit users_path }.to raise_error ActionController::RoutingError
          else
            visit users_path
            expect(page.status_code).to eq 403
            expect(page).to have_content 'Access Denied'
          end
        end
      end
    end
  end

  describe 'sign up' do
    it 'signs up', :vcr do
      unless RadCommon.disable_sign_up
        visit new_user_registration_path

        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Mobile phone', with: '(345) 222-1111'
        fill_in 'Email', with: Faker::Internet.user_name + '@example.com'
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password

        click_button 'Sign Up'
        expect(page).to have_content 'message with a confirmation link has been sent'
      end
    end

    it "can't sign up with invalid email address" do
      unless RadCommon.disable_sign_up
        visit new_user_registration_path

        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Email', with: 'test_user@'
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password

        click_button 'Sign Up'

        expect(page).to have_content 'is not authorized'
      end
    end
  end

  describe 'sign in' do
    it 'can not sign in without active user status' do
      user.update!(user_status: UserStatus.default_pending_status)

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
      fill_in 'user_email', with: 'foo' + user.email
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

    it 'cannot sign in when expired' do
      if Devise.mappings[:user].expirable?
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

    it 'sign in times out after 2 hours' do
      if Devise.mappings[:user].timeoutable?
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: password
        click_button 'Sign In'
        expect(page).to have_content('Signed in successfully')

        Timecop.travel(125.minutes.from_now)
        visit users_path
        expect(page).to have_content('Your session expired. Please sign in again to continue.')
        Timecop.return
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

  describe 'devise paranoid setting' do
    it 'wrong password - does not specify if email or password is wrong' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      click_button 'Sign In'
      expect(page).to have_content('Invalid Email or password.')
    end

    describe 'confirming' do
      let(:user) { create(:user, confirmed_at: nil) }

      let(:message) do
        'If your email address exists in our database, you will receive an email with instructions for how to '\
        'confirm your email address in a few minutes.'
      end

      it "doesn't say whether the email exists" do
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
        'If your email address exists in our database, you will receive a password recovery link at your email '\
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

      context 'with a different user' do
        let(:another_user) { create :admin }

        it 'updates last_activity_at' do
          if Devise.mappings[:user].expirable?
            another_user.update!(last_activity_at: 91.days.ago)
            expect(another_user.expired?).to eq(true)
            visit edit_user_path(another_user)
            fill_in :user_last_activity_at, with: Date.current
            click_button 'Save'
            expect(page).to have_content('User updated')
            expect(another_user.reload.last_activity_at.to_date).to eq(Date.current)
            expect(another_user.expired?).to eq(false)
          end
        end
      end
    end
  end

  describe 'two factor authentication' do
    let(:authy_id) { '1234567' }

    before do
      expect(Authy::API).to receive(:register_user).and_return(double(:response, ok?: true, id: authy_id))
      user.update!(authy_enabled: true, mobile_phone: create(:phone_number, :mobile))
    end

    it 'allows user to login with authentication token', :vcr do
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

    it 'does not allow user to login with invalid authy token', :vcr do
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
      fill_in 'user_mobile_phone', with: create(:phone_number, :mobile)
      fill_in 'user_current_password', with: password
      click_button 'Save'
      expect(page).to have_content('Your account has been updated successfully.')
    end
  end
end
