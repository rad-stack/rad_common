require 'rails_helper'

describe 'Sendgrid', type: :request do
  describe 'POST email_error' do
    let!(:admin_user_1) { create :admin }
    let!(:admin_user_2) { create :admin }

    it 'sends an email to app admins' do
      create :user

      ActionMailer::Base.deliveries = []

      sendgrid_info = { _json: [{ email: 'example@test.com', timestamp: 1_493_994_015 }] }
      post '/rad_common/email_error', params: sendgrid_info.merge(use_route: :rad_common)
      emails = ActionMailer::Base.deliveries
      expect(emails.count).to eq(2)

      all_tos = emails.map(&:to).flatten

      expect(all_tos).to include(admin_user_1.email)
      expect(all_tos).to include(admin_user_2.email)

      expect(emails.first.subject).to eq('Invalid Email')
      expect(emails.last.subject).to eq('Invalid Email')
    end
  end
end
