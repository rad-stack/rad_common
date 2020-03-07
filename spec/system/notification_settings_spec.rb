require 'rails_helper'

RSpec.describe 'NotificationSettings', type: :system do
  let(:notification_type) { Notifications::NewUserSignedUpNotification.main }
  let(:security_role) { create :security_role, :admin }

  let!(:notification_security_role) do
    create :notification_security_role, notification_type: notification_type, security_role: security_role
  end

  before { login_as user, scope: :user }

  describe 'index' do
    context 'admin' do
      let(:user) { create :admin, security_roles: [security_role] }

      it 'displays the settings' do
        visit '/rad_common/notification_settings'
        expect(page).to have_content(notification_type.description)
      end

      it 'updates the settings successfully without save button', :js do
        visit '/rad_common/notification_settings'
        expect(NotificationSetting.count).to eq 0
        page.check('notification_setting[feed]')
        sleep 2
        expect(NotificationSetting.count).to eq 1
      end

      it 'displays error message when updating without button', :js do
        visit '/rad_common/notification_settings'
        page.uncheck('notification_setting[email]')
        expect(accept_alert).to eq 'The setting could not be saved: Enabled requires one of email/sms/feed be turned on'
      end
    end

    context 'user' do
      let(:user) { create :user }

      it 'does not display the settings' do
        visit '/rad_common/notification_settings'
        expect(page).not_to have_content(notification_type.description)
        expect(page).to have_content 'Access Denied'
      end
    end
  end
end
