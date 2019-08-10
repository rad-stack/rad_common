require 'rails_helper'

RSpec.describe 'SystemMessages', type: :system do
  let(:user) { create :admin }
  let!(:system_message) { create :system_message, user: user }

  before { login_as(user, scope: :user) }

  describe 'new' do
    it 'sends' do
      visit 'rad_common/system_messages/new'
      expect(page).to have_content 'Send System Message'
      click_button 'Send'
      expect(page).to have_content 'The message was successfully sent'
    end
  end

  describe 'show' do
    before { visit "rad_common/system_messages/#{system_message.id}" }

    it 'shows the message' do
      expect(page).to have_content(system_message.message)
    end
  end
end
