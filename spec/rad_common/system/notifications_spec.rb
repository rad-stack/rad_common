require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  let(:user) { create :admin }
  let(:notification_type) { create :new_user_signed_up_notification }

  before { login_as user, scope: :user }

  describe 'index' do
    let(:notification) { user.notifications.recent_first.first }

    before { create_list :notification, 50, user: user, notification_type: notification_type }

    it 'displays the notification types' do
      visit '/rad_common/notifications'
      expect(page).to have_content(notification.content)
    end
  end
end
