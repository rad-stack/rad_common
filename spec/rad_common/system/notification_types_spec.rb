require 'rails_helper'

RSpec.describe 'NotificationTypes', type: :system do
  let(:user) { create :admin }
  let(:notification_type) { create :new_user_signed_up_notification }

  before { login_as user, scope: :user }

  describe 'edit' do
    it 'renders the edit template' do
      visit "/rad_common/notification_types/#{notification_type.id}/edit"
      expect(page).to have_content('Editing Notification Type')
    end
  end

  describe 'index' do
    it 'displays the notification types' do
      notification_type
      visit '/rad_common/notification_types'
      expect(page).to have_content(notification_type.description)
    end
  end
end
