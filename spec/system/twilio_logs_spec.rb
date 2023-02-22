require 'rails_helper'

RSpec.describe 'TwilioLogs' do
  let(:user) { create :admin }
  let(:twilio_log) { create :twilio_log }

  before { login_as user, scope: :user }

  describe 'index' do
    it 'displays the twilio_logs' do
      twilio_log
      visit '/rad_common/twilio_logs'
      expect(page).to have_content(twilio_log.message)
    end
  end
end
