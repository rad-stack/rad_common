require 'rails_helper'

RSpec.describe Notifications::NewUserSignedUpNotification, type: :model do
  let(:user) { create :user }
  let(:security_role) { user.security_roles.first }
  let(:notification_type) { create :new_user_signed_up_notification, security_roles: [security_role] }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify! user
    end

    it 'emails' do
      expect(mail.subject).to eq "New User on #{RadConfig.app_name!}"
    end
  end
end
