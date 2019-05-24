require 'rails_helper'

RSpec.describe NotificationType, type: :model do
  let!(:user) { create :admin }
  let(:notification_type) { NotificationType.find_by(name: 'Notifications::NewUserSignedUpNotification') }

  describe 'validity' do
    it 'requires notifications to have users to notify' do
      expect(notification_type.valid?).to be true
      user.update! security_roles: []
      expect(notification_type.valid?).to be false
      expect(notification_type.errors.full_messages.to_s).to include 'empty notify list'
    end
  end

  describe '#notify_user_ids' do
    let(:notification_type) { Notifications::GlobalValidityNotification }
    subject { notification_type.send(:notify_user_ids) }
    it { is_expected.to eq [user.id] }
  end

  describe '#notify_list' do
    let!(:another) { create :admin }
    subject { notification_type.notify_list(true) }

    it { is_expected.to include user }
    it { is_expected.to include another }

    context 'when user opts out' do
      before do
        create :notification_setting, user: user,
                                      notification_type: NotificationType.find_by(name: 'Notifications::NewUserSignedUpNotification'),
                                      enabled: false
      end

      it { is_expected.to include another }
      it { is_expected.to_not include user }
    end

    context 'inactive user' do
      before { user.update! user_status: UserStatus.default_inactive_status }
      it { is_expected.to_not include user }
    end
  end
end
