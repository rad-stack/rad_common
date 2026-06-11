require 'rails_helper'

RSpec.describe 'ContactLogs' do
  let(:user) { create :admin }
  let(:contact_log_recipient) { create :contact_log_recipient, contact_log: contact_log }
  let(:contact_log) { create :contact_log, record: attorney }
  let(:attorney) { create :attorney }

  before { login_as user, scope: :user }

  describe 'index' do
    it 'displays the contact_logs' do
      contact_log_recipient
      visit '/contact_logs'
      click_on 'When'
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

    context 'when the contact log has an email body' do
      let(:contact_log) { create :contact_log, :email, record: attorney, email_body: 'The full email body content.' }

      it 'shows the email body' do
        visit contact_log_path(contact_log)
        expect(page).to have_content('The full email body content.')
      end
    end

    context 'when the contact log has no email body' do
      it 'does not show an email body field' do
        visit contact_log_path(contact_log)
        expect(page).to have_content(contact_log.content)
        expect(page).to have_no_content('Email Body')
      end
    end
  end
end
