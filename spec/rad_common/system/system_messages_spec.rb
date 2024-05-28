require 'rails_helper'

RSpec.describe 'SystemMessages', type: :system do
  let(:user) { create :admin }
  let!(:system_message) { create :system_message, :email, user: user }

  before { login_as user, scope: :user }

  describe 'new' do
    context 'with twilio disabled' do
      before do
        allow(RadConfig).to receive(:twilio_enabled?).and_return false
        visit '/rad_common/system_messages/new'
      end

      it 'sends' do
        expect(page).to have_content 'Send System Message'
        click_button 'Send'
        expect(page).to have_content 'The message was successfully sent'
      end

      it 'does not show the sms option' do
        expect(page.all('#system_message_message_type option').map(&:value)).to eq ['email']
      end

      xit 'shows custom trix actions', :js do
        expect(page.body).to include 'trix-button--icon-color'
      end
    end

    context 'with twilio enabled' do
      before do
        allow(RadConfig).to receive(:twilio_enabled?).and_return true
        visit '/rad_common/system_messages/new'
      end

      it 'shows the sms option' do
        expect(page.all('#system_message_message_type option').map(&:value)).to eq %w[email sms]
      end

      it 'sets the message type based on the previous system message' do
        expect(find_field('Message Type').value).to eq 'email'
        create :system_message, :sms, user: user
        visit '/rad_common/system_messages/new'
        expect(find_field('Message Type').value).to eq 'sms'
      end

      context 'when dynamically changing fields', :js do
        xit 'shows and hides trix editor based on message type' do
          find('body').click
          expect(page).to have_css('.email-message', visible: :visible)
          expect(page).to have_css('.sms-message', visible: :hidden)
          select 'SMS', from: 'Message Type'
          expect(page).to have_css('.email-message', visible: :hidden)
          expect(page).to have_css('.sms-message', visible: :visible)
        end
      end
    end
  end

  describe 'show' do
    before { visit "/rad_common/system_messages/#{system_message.id}" }

    it 'shows the message' do
      expect(page).to have_content(system_message.email_message_body.to_plain_text)
    end

    it 'shows the message type' do
      expect(page).to have_content(system_message.message_type.capitalize)
    end
  end
end
