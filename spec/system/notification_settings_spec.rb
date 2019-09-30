require 'rails_helper'

RSpec.describe 'NotificationSettings', type: :system do
  let(:notification_type) { create :notification_type }
  let(:security_role) { create :security_role, :admin }

  let!(:notification_security_role) do
    create :notification_security_role, notification_type: notification_type, security_role: security_role
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    context 'admin' do
      let(:user) { create :admin, security_roles: [security_role] }

      it 'displays the settings' do
        visit '/rad_common/notification_settings'
        expect(page).to have_content(notification_type.description)
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
