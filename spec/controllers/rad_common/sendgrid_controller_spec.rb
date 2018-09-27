require 'rails_helper'

describe RadCommon::SendgridController, type: :controller do
  describe 'POST email_error' do
    let!(:super_admin_user1) { create(:user, super_admin: true) }
    let!(:super_admin_user2) { create(:user, super_admin: true) }
    let!(:normal_user) { create(:user, super_admin: false) }
    let!(:company) { Company.main }

    it 'sends an email to app admins' do
      ActionMailer::Base.deliveries = []

      sendgrid_info = { "_json"=>[{"email"=>"example@test.com", "timestamp"=>1493994015}] }
      post :email_error, params: sendgrid_info.merge({ use_route: :rad_common})
      emails = ActionMailer::Base.deliveries
      expect(emails.count).to eq(2)

      expect(emails.first.to).to eq([super_admin_user1.email])
      expect(emails.last.to).to eq([super_admin_user2.email])

      expect(emails.first.subject).to eq('Invalid Email')
      expect(emails.last.subject).to eq('Invalid Email')
    end
  end
end
