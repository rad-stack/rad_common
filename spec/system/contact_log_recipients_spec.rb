require 'rails_helper'

RSpec.describe 'ContactLogRecipients' do
  let(:user) { create :admin }
  let(:contact_log_recipient) { create :contact_log_recipient }
  let(:contact_log) { contact_log_recipient.contact_log }

  before { login_as user, scope: :user }

  describe 'show' do
    it 'shows the contact_log' do
      visit contact_log_recipient_path(contact_log_recipient)
      expect(page).to have_content(contact_log.content)
    end
  end
end
