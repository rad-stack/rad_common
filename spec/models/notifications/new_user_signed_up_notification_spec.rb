require 'rails_helper'

RSpec.describe Notifications::NewUserSignedUpNotification, type: :model do
  let!(:admin) { create :admin }
  let(:security_role) { admin.security_roles.first }
  let(:user) { create :user }
  let(:notification_type) { described_class.new }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      create :notification_security_role, notification_type: notification_type, security_role: security_role
      ActionMailer::Base.deliveries = []
      notification_type.notify! user
    end

    it 'emails' do
      expect(mail.subject).to eq "New User on #{I18n.t(:app_name)}"
    end
  end
end
