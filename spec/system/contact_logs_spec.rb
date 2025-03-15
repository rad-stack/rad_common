require 'rails_helper'

RSpec.describe 'ContactLogs' do
  let(:user) { create :admin }
  let(:contact_log_recipient) { create :contact_log_recipient, contact_log: contact_log }
  let(:contact_log) { create :contact_log, record: attorney }
  let(:attorney) { create :attorney }

  before { login_as user, scope: :user }

  describe 'index' do
    xit 'displays the contact_logs' do
      contact_log_recipient
      visit '/contact_logs'
      expect(page).to have_content(contact_log_recipient.contact_log.content)
      expect(page).to have_content(contact_log_recipient.to_user.to_s)
    end
  end

  describe 'show' do
    it 'shows the contact_log' do
      visit contact_log_path(contact_log)
      expect(page).to have_content(contact_log.content)
      expect(page).to have_content('Attorney')
    end
  end
end
