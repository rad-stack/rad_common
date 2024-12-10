require 'rails_helper'

RSpec.describe Notifications::UserWasApprovedNotification, type: :model do
  let(:admin) { create :admin }
  let(:another) { create :admin }
  let(:user) { create :user }
  let(:notification_type) { create :user_was_approved_notification, security_roles: [admin.security_roles.first] }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify_user_ids_opted' do
    before { notification_type.payload = payload }

    context 'when user is approved' do
      subject { notification_type.send(:notify_user_ids_opted, :email) }

      let(:payload) { [user, admin] }

      it { is_expected.to include admin.id }
    end

    context 'when admin is approved' do
      subject { notification_type.send(:notify_user_ids_opted, :email) }

      let(:payload) { [another, admin] }

      it { is_expected.to include admin.id }
      it { is_expected.not_to include another.id }
    end
  end

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification_type.notify! [user, admin]
    end

    it 'emails' do
      expect(mail.subject).to eq "User Was Approved on #{RadConfig.app_name!}"
    end
  end
end
