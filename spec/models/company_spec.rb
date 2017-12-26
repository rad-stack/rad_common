require 'rails_helper'

describe Company, type: :model do
  let(:company) { Company.main }
  let!(:user) { create :admin }

  it 'should send system message' do
    ActionMailer::Base.deliveries = []

    company.send_system_message('foo@bar.com', 'foo bar yo')

    mail = ActionMailer::Base.deliveries.last
    expect(mail.body.encoded).to include 'foo bar yo'
  end
end
