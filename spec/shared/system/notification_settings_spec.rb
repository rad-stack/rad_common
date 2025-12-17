require 'rails_helper'

RSpec.describe 'NotificationSettings', type: :system do
  let!(:security_role) { create :security_role, :admin }
  let!(:notification_type) { Notifications::NewUserSignedUpNotification.main }

  before { login_as user, scope: :user }

  describe 'index' do
    context 'when admin' do
      let(:user) { create :admin, security_roles: [security_role] }

      it 'displays the settings' do
        visit '/notification_settings'
        expect(page).to have_content(notification_type.description)
      end

      it 'updates the settings successfully without save button', :js, :legacy_asset_specs do
        visit '/notification_settings'
        expect(NotificationSetting.count).to eq 0
        page.check('notification_setting[feed]')
        wait_for_ajax
        expect(NotificationSetting.count).to eq 1
      end

      it 'displays error message when updating without button', :js, :legacy_asset_specs do
        visit '/notification_settings'
        page.uncheck('notification_setting[email]')
        alert = accept_alert do
          page.uncheck('notification_setting[email]')
        end
        expect(alert).to eq 'The setting could not be saved: Enabled requires one of email/sms/feed be turned on'
        network_errors = page.driver.network_traffic.select { |r| r.response.status >= 400 }

        expect(network_errors.last.response.status).to eq(422)
        expect(network_errors.last.response.body).to include 'The setting could not be saved: Enabled requires one ' \
                                                             'of email/sms/feed be turned on'
      end
    end

    context 'when user' do
      let(:user) { create :user }

      it 'does not display the settings' do
        visit '/notification_settings'
        expect(page).to have_no_content(notification_type.description)
        expect(page).to have_content 'Access Denied'
      end
    end
  end
end
