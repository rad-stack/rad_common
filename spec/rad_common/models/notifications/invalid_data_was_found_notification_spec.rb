require 'rails_helper'

RSpec.describe Notifications::InvalidDataWasFoundNotification, type: :model do
  let(:user) { create :user }
  let(:security_role) { user.security_roles.first }
  let(:notification_type) { create :global_validity_notification, security_roles: [security_role] }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify! []
    end

    it 'emails' do
      expect(mail.subject).to eq "Invalid data in #{RadConfig.app_name!}"
    end
  end
end
