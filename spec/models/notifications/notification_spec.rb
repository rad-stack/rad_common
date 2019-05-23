require 'rails_helper'

RSpec.describe Notifications::Notification, type: :model do
  let!(:admin) { create :admin }
  let(:notification) { Notifications::NewUserSignedUpNotification.new }

  describe '#notify_list' do
    let!(:another) { create :admin }
    subject { notification.send(:notify_list, true) }

    it { is_expected.to include admin }
    it { is_expected.to include another }

    context 'when user opts out' do
      before do
        create :notification_setting, user: admin,
                                      notification_type: 'Notifications::NewUserSignedUpNotification',
                                      enabled: false
      end

      it { is_expected.to include another }
      it { is_expected.to_not include admin }
    end

    context 'inactive user' do
      before { admin.update! user_status: UserStatus.default_inactive_status }
      it { is_expected.to_not include admin }
    end
  end

  describe '#notify_user_ids' do
    subject { notification.send(:notify_user_ids) }
    it { is_expected.to eq [admin.id] }
  end
end
