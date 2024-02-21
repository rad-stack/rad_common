require 'rails_helper'

RSpec.describe Notifications::NewUserSignedUpNotification, type: :model do
  let(:user) { create :user }
  let(:notification_type) { described_class.main(user) }
  let(:mail) { ActionMailer::Base.deliveries.last }

  before do
    create :admin
    notification_type
  end

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify!
    end

    it 'emails' do
      expect(mail.subject).to eq "New User on #{RadConfig.app_name!}"
    end
  end
end
