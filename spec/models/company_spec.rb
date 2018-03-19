require 'rails_helper'

describe Company, type: :model do
  let(:company) { Company.main }

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
