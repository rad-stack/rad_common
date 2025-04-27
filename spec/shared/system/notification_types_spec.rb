require 'rails_helper'

RSpec.describe 'NotificationTypes', type: :system do
  let(:user) { create :admin }
  let(:notification_type) { Notifications::NewUserSignedUpNotification.main }

  before { login_as user, scope: :user }

  describe 'edit' do
    xit 'renders the edit template' do
      visit "/notification_types/#{notification_type.id}/edit"
      expect(page).to have_content('Editing Notification Type')
    end
  end

  describe 'index' do
    it 'displays the notification types' do
      notification_type
      visit '/notification_types'
      expect(page).to have_content(notification_type.description)
    end
  end
end
