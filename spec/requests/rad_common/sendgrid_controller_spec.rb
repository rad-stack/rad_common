require 'rails_helper'

describe 'Sendgrid', type: :request do
  describe 'POST email_error' do
    let!(:admin_user1) { create :admin }
    let!(:admin_user2) { create :admin }
    let!(:normal_user) { create :user }
    let!(:company) { Company.main }

    it 'sends an email to app admins' do
      ActionMailer::Base.deliveries = []

      sendgrid_info = { '_json': [{ 'email': 'example@test.com', 'timestamp': 1_493_994_015 }] }
      post '/rad_common/email_error', params: sendgrid_info.merge(use_route: :rad_common)
      emails = ActionMailer::Base.deliveries
      expect(emails.count).to eq(2)

      expect(emails.first.to).to eq([admin_user1.email])
      expect(emails.last.to).to eq([admin_user2.email])

      expect(emails.first.subject).to eq('Invalid Email')
      expect(emails.last.subject).to eq('Invalid Email')
    end
  end
end
