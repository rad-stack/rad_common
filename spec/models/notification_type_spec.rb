require 'rails_helper'

RSpec.describe NotificationType, type: :model do
  let(:security_role) { create :security_role, :admin }
  let!(:user) { create :admin, security_roles: [security_role] }
  let(:notification_type) { create :notification_type }

  let!(:notification_security_role) do
    create :notification_security_role, notification_type: notification_type, security_role: security_role
  end

  describe '#notify_user_ids' do
    let(:notification_class) { Notifications::GlobalValidityNotification }
    subject { notification_class.send(:notify_user_ids) }
    it { is_expected.to eq [user.id] }
  end

  describe '#notify_list' do
    let!(:another) { create :admin, security_roles: [security_role] }
    subject { notification_type.notify_list(true) }

    it { is_expected.to include user }
    it { is_expected.to include another }

    context 'when user opts out' do
      before do
        create :notification_setting, user: user, notification_type: notification_type, enabled: false
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
