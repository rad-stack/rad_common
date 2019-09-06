require 'rails_helper'

RSpec.describe 'SystemMessages', type: :system do
  let(:user) { create :admin }
  let!(:system_message) { create :system_message, user: user }

  before { login_as(user, scope: :user) }

  describe 'new' do
    context 'twilio disabled' do
      before do
        allow(RadicalTwilio).to receive(:twilio_enabled?).and_return false
        visit 'rad_common/system_messages/new'
      end

      it 'sends' do
        expect(page).to have_content 'Send System Message'
        click_button 'Send'
        expect(page).to have_content 'The message was successfully sent'
      end

      it 'does not show the sms option' do
        expect(page.all('#system_message_message_type option').map(&:value)).to eq ['email']
      end
    end

    context 'twilio enabled' do
      before do
        allow(RadicalTwilio).to receive(:twilio_enabled?).and_return true
        visit 'rad_common/system_messages/new'
      end

      it 'shows the sms option' do
        expect(page.all('#system_message_message_type option').map(&:value)).to eq ['email', 'sms']
      end

      it 'sets the message type based on the previous system message' do
        expect(find_field('Message type').value).to eq 'email'
        create(:system_message, message_type: 'sms', user: user)
        visit 'rad_common/system_messages/new'
        expect(find_field('Message type').value).to eq 'sms'
      end

      context 'dynamically changing fields', js: true do
        it 'shows and hides trix editor based on message type' do
          expect(find('.email-message', visible: true))
          expect(find('.sms-message', visible: false))
          select 'Sms', from: 'Message type'
          expect(find('.email-message', visible: false))
          expect(find('.sms-message', visible: true))
        end
      end
    end
  end

  describe 'show' do
    before { visit "rad_common/system_messages/#{system_message.id}" }

    it 'shows the message' do
      expect(page).to have_content(system_message.message)
    end

    it 'shows the message type' do
      expect(page).to have_content(system_message.message_type.capitalize)
    end
  end
end
