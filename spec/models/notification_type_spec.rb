require 'rails_helper'

RSpec.describe NotificationType, type: :model do
  let(:security_role) { create :security_role, :admin }
  let!(:user) { create :admin, security_roles: [security_role] }
  let(:notification_type) { create :notification_type }

  let!(:notification_security_role) do
    create :notification_security_role, notification_type: notification_type, security_role: security_role
  end

  describe '#notify_user_ids' do
    subject { notification_class.send(:notify_user_ids, user) }

    let(:notification_class) { Notifications::GlobalValidityNotification }

    it { is_expected.to eq [user.id] }
  end

  describe '#notify_list' do
    subject { notification_type.notify_list(true) }

    let!(:another) { create :admin, security_roles: [security_role] }

    it { is_expected.to include user }
    it { is_expected.to include another }

    context 'when user opts out' do
      before do
        create :notification_setting, user: user, notification_type: notification_type, enabled: false
      end

      it { is_expected.to include another }
      it { is_expected.not_to include user }
    end

    context 'inactive user' do
      before { user.update! user_status: UserStatus.default_inactive_status }

      it { is_expected.not_to include user }
    end
  end
end
