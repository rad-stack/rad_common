require 'rails_helper'

describe 'Users', type: :system do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:password) { 'password' }
  let(:external_user) { create :user, :external }

  describe 'authenticated' do
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
      let!(:notification_type) { Notifications::NewUserSignedUpNotification.create! security_roles: [user.security_roles.first] }
      let(:notification_setting) { NotificationSetting.find_by(user: user, notification_type: notification_type) }
      let(:external_user) { create :user, :external }

      before { login_as admin, scope: :user }

      describe 'index' do
        it 'shows users' do
          external_user.update! user_status: user.user_status
          visit users_path(status: user.user_status_id)
          expect(page).to have_content user.to_s
          expect(page).to have_content external_user.to_s
        end

        it 'filters by user type' do
          external_user.update!(user_status: user.user_status)
          visit users_path(status: user.user_status_id, external: true)
          expect(page).not_to have_content user.email
          expect(page).to have_content external_user.email
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
          visit user_path(external_user)
          expect(page).to have_content admin.first_name
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
          accept_confirm do
            click_link 'Confirm Email'
          end

          expect(page.html).to include 'User was successfully confirmed'
        end
      end
    end
  end

  describe 'client user' do
    before { login_as external_user, scope: :user }

    describe 'show' do
      it 'does not allow' do
        visit user_path(user)
        expect(page.status_code).to eq 403
        expect(page).to have_content 'Access Denied'
      end
    end

    describe 'index' do
      it 'does not allow' do
        visit users_path
        expect(page.status_code).to eq 403
        expect(page).to have_content 'Access Denied'
      end
    end
  end

  describe 'sign up' do
    it 'signs up' do
      unless RadCommon.disable_sign_up
        visit new_user_registration_path

        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Email', with: Faker::Internet.user_name + '@example.com'
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password

        click_button 'Sign Up'
        expect(page.html).to include('message with a confirmation link has been sent')
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

        expect(page.html).to include('is not authorized')
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
      expect(page.html).to include('Your account has not been approved by your administrator yet.')
    end

    it 'signs in' do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password

      click_button 'Sign In'
      expect(page.html).to include('Signed in successfully.')
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
end
