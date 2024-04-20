require 'rails_helper'

RSpec.describe 'ContactLogs' do
  let(:user) { create :admin }
  let(:contact_log_recipient) { create :contact_log_recipient }

  before { login_as user, scope: :user }

  describe 'index' do
    it 'displays the contact_logs' do
      contact_log_recipient
      visit '/rad_common/contact_logs'
      expect(page).to have_content(contact_log_recipient.contact_log.content)
      expect(page).to have_content(contact_log_recipient.to_user.to_s)
    end
  end
end
