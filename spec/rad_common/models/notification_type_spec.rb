require 'rails_helper'

RSpec.describe NotificationType, type: :model do
  let(:user) { create :admin }
  let(:security_role) { user.security_roles.first }
  let(:notification_type) { create :global_validity_notification, security_roles: [security_role] }
  let(:notification_method) { :email }
  let(:notification_payload) { [] }

  before { notification_type.payload = notification_payload }

  describe 'notify_feed' do
    subject { user.notifications.last.unread }

    before do
      create :notification_setting, user: user,
                                    notification_type: notification_type,
                                    enabled: true,
                                    feed: opt_in

      notification_type.send(:notify_feed!)
    end

    context 'when opted in' do
      let(:opt_in) { true }

      it { is_expected.to be true }
    end

    context 'when opted out' do
      let(:opt_in) { false }

      it { is_expected.to be false }
    end
  end

  describe 'notify_user_ids_opted with security_roles' do
    subject { notification_type.send(:notify_user_ids_opted, notification_method) }

    let!(:another) { create :admin, security_roles: [security_role] }

    it { is_expected.to include user.id }
    it { is_expected.to include another.id }

    context 'when user opts out' do
      before { create :notification_setting, user: user, notification_type: notification_type, enabled: false }

      it { is_expected.not_to include user.id }
      it { is_expected.to include another.id }
    end

    context 'with inactive user' do
      before { user.update! user_status: UserStatus.default_inactive_status }

      it { is_expected.not_to include user.id }
      it { is_expected.to include another.id }
    end

    context 'when excluding users' do
      before { allow(notification_type).to receive(:exclude_user_ids).and_return [user.id] }

      it { is_expected.not_to include user.id }
      it { is_expected.to include another.id }
    end

    context 'when email is turned off' do
      before do
        create :notification_setting, user: user,
                                      notification_type: notification_type,
                                      enabled: true,
                                      email: false,
                                      feed: true
      end

      it { is_expected.not_to include user.id }
      it { is_expected.to include another.id }
    end

    context 'when feed' do
      let(:notification_method) { :feed }

      context 'without setting' do
        it { is_expected.not_to include user.id }
        it { is_expected.not_to include another.id }
      end

      context 'with setting enabled' do
        before do
          create :notification_setting, user: user,
                                        notification_type: notification_type,
                                        enabled: true,
                                        email: false,
                                        feed: true
        end

        it { is_expected.to include user.id }
        it { is_expected.not_to include another.id }
      end

      context 'with setting disabled' do
        before do
          create :notification_setting, user: user,
                                        notification_type: notification_type,
                                        enabled: true,
                                        email: true,
                                        feed: false
        end

        it { is_expected.not_to include user.id }
        it { is_expected.not_to include another.id }
      end
    end
  end
end
