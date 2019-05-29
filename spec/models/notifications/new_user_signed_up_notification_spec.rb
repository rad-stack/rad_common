require 'rails_helper'

RSpec.describe Notifications::NewUserSignedUpNotification, type: :model do
  let!(:admin) { create :admin }
  let(:user) { create :user }
  let(:notification) { described_class }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification.notify! user
    end

    it 'emails' do
      expect(mail.subject).to eq "New User on #{I18n.t(:app_name)}"
    end
  end
end
