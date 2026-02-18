require 'rails_helper'

RSpec.describe 'Notification Defaults' do
  let!(:security_role) { create :security_role, :admin }
  let!(:notification_type) { Notifications::AttorneyChangedNotification.main }

  before do
    allow(RadConfig).to receive(:twilio_enabled?).and_return(true)
    login_as user, scope: :user
  end

  describe 'notification settings page' do
    let(:user) { create :admin, security_roles: [security_role] }

    it 'shows the correct default checkboxes for a new user' do
      visit '/notification_settings'

      expect(page).to have_content('Attorney Changed')
      expect(page).to have_checked_field('notification_setting_email_attorney_changed')
      expect(page).to have_checked_field('notification_setting_sms_attorney_changed')
      expect(page).to have_field('notification_setting_feed_attorney_changed', disabled: true)
    end
  end

  describe 'apply to all settings' do
    let(:admin) { create :admin, security_roles: [security_role] }
    let(:user) { admin }
    let!(:other_user) { create :admin, security_roles: [security_role] }

    before do
      NotificationSetting.create!(notification_type: notification_type, user: other_user,
                                  enabled: true, email: true, sms: true, feed: false)
    end

    context 'when apply to all is checked', :js do
      it 'updates all existing notification settings' do
        visit "/notification_types/#{notification_type.id}/edit"
        uncheck 'Default sms'
        check 'Apply to all existing settings'
        click_button 'Save'

        setting = NotificationSetting.find_by(notification_type: notification_type, user: other_user)
        expect(setting.email).to be true
        expect(setting.sms).to be false
        expect(setting.feed).to be false
      end
    end

    context 'when apply to all is not checked', :js do
      it 'does not update existing notification settings' do
        visit "/notification_types/#{notification_type.id}/edit"
        uncheck 'Default sms'
        click_button 'Save'

        setting = NotificationSetting.find_by(notification_type: notification_type, user: other_user)
        expect(setting.email).to be true
        expect(setting.sms).to be true
        expect(setting.feed).to be false
      end
    end
  end

  describe 'new defaults only apply going forward' do
    let(:admin) { create :admin, security_roles: [security_role] }
    let(:user) { admin }
    let!(:original_user) { create :admin, security_roles: [security_role] }

    before do
      NotificationSetting.create!(notification_type: notification_type, user: original_user,
                                  enabled: true, email: true, sms: true, feed: false)
    end

    it 'new user gets new defaults but original user keeps old settings', :js do
      visit "/notification_types/#{notification_type.id}/edit"
      uncheck 'Default sms'
      click_button 'Save'

      original_setting = NotificationSetting.find_by(notification_type: notification_type, user: original_user)
      expect(original_setting.sms).to be true

      new_user = create :admin, security_roles: [security_role]
      logout
      login_as new_user, scope: :user
      visit '/notification_settings'

      expect(page).to have_checked_field('notification_setting_email_attorney_changed')
      expect(page).to have_no_checked_field('notification_setting_sms_attorney_changed')
    end
  end
end
