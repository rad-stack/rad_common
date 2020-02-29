require 'rails_helper'

RSpec.describe NotificationType, type: :model do
  let(:security_role) { create :security_role, :admin }
  let!(:user) { create :admin, security_roles: [security_role] }
  let(:notification_class) { notification_name.constantize }
  let(:notification_type) { create :notification_type, name: notification_name, auth_mode: auth_mode }
  let(:notification_method) { :email }
  let(:notification_name) { 'Notifications::GlobalValidityNotification' }
  let(:notifier) { notification_class.new }
  let(:notification_payload) { [] }
  let(:auth_mode) { :security_roles }

  before do
    create :notification_security_role, notification_type: notification_type, security_role: security_role
    notifier.payload = notification_payload
  end

  describe 'notify_feed' do
    subject { user.notifications.last.unread }

    before do
      create :notification_setting, user: user,
                                    notification_type: notification_type,
                                    enabled: true,
                                    feed: opt_in

      notifier.send(:notify_feed!)
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

  describe 'notify_user_ids_opted with absolute_user' do
    # remove this on all other apps, division is only in dummy app of rad_common
    subject { notifier.send(:notify_user_ids_opted, notification_method) }

    let(:notification_name) { 'Notifications::NewDivisionNotification' }
    let(:notification_payload) { create :division, owner: user }
    let(:auth_mode) { :absolute_user }

    it { is_expected.to eq [user.id] }

    context 'when user opts out' do
      before { create :notification_setting, user: user, notification_type: notification_type, enabled: false }

      it { is_expected.to eq [] }
    end

    context 'with inactive user' do
      before { user.update! user_status: UserStatus.default_inactive_status }

      it { expect { subject }.to raise_error 'absolute user must be active' }
    end

    context 'when email is turned off' do
      before do
        create :notification_setting, user: user,
                                      notification_type: notification_type,
                                      enabled: true,
                                      email: false,
                                      feed: true
      end

      it { is_expected.to eq [] }
    end

    context 'when feed' do
      let(:notification_method) { :feed }

      context 'without setting' do
        it { is_expected.to eq [] }
      end

      context 'with setting enabled' do
        before do
          create :notification_setting, user: user,
                                        notification_type: notification_type,
                                        enabled: true,
                                        email: false,
                                        feed: true
        end

        it { is_expected.to eq [user.id] }
      end

      context 'with setting disabled' do
        before do
          create :notification_setting, user: user,
                                        notification_type: notification_type,
                                        enabled: true,
                                        email: true,
                                        feed: false
        end

        it { is_expected.to eq [] }
      end
    end
  end

  describe 'notify_user_ids_opted with security_roles' do
    subject { notifier.send(:notify_user_ids_opted, notification_method) }

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
      before { allow(notifier).to receive(:exclude_user_ids).and_return [user.id] }

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
