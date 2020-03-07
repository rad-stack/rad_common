require 'rails_helper'

RSpec.describe Notifications::GlobalValidityNotification, type: :model do
  let!(:admin) { create :admin }
  let(:security_role) { admin.security_roles.first }
  let(:notification_type) { described_class.main }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      create :notification_security_role, notification_type: notification_type, security_role: security_role
      ActionMailer::Base.deliveries = []
      notification_type.notify! []
    end

    it 'emails' do
      expect(mail.subject).to eq "Invalid data in #{I18n.t(:app_name)}"
    end
  end
end
