require 'rails_helper'

RSpec.describe 'NotificationSettings', type: :request do
  let(:notification) { 'New User Signed Up' }

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    context 'admin' do
      let(:user) { create :admin }

      it 'displays the settings' do
        visit '/rad_common/notification_settings'
        expect(page).to have_content(notification)
      end
    end

    context 'user' do
      let(:user) { create :user }

      it 'does not display the settings' do
        visit '/rad_common/notification_settings'
        expect(page).to_not have_content(notification)
        expect(page).to have_content 'Access Denied'
      end
    end
  end
end
