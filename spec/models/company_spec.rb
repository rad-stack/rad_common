require 'rails_helper'

describe Company, type: :model do
  let(:company) { Company.main }

  describe 'validate' do
    it 'should require at least one valid user domain' do
      company.valid_user_domains = []
      expect(company.valid?).to be false
      expect(company.errors.full_messages.to_s).to include 'needs at least one domain'

      company.valid_user_domains = ['example.com']
      expect(company.valid?).to be true
    end
  end

  describe 'system messages' do
    let!(:user) { create :admin }

    it 'should send ' do
      ActionMailer::Base.deliveries = []

      company.send_system_message('foo@bar.com', 'foo bar yo')

      mail = ActionMailer::Base.deliveries.last
      expect(mail.body.encoded).to include 'foo bar yo'
    end
  end
end
