require 'rails_helper'

RSpec.describe 'ContactLogs' do
  let(:user) { create :admin }
  let(:contact_log) { create :contact_log }

  before { login_as user, scope: :user }

  describe 'index' do
    it 'displays the contact_logs' do
      contact_log
      visit '/rad_common/contact_logs'
      expect(page).to have_content(contact_log.message)
    end
  end
end
