require 'rails_helper'

RSpec.describe NotificationType, type: :model do
  let(:security_role) { create :security_role, :admin }
  let!(:user) { create :admin, security_roles: [security_role] }
  let(:notification_class) { notification_name.constantize }
  let(:notification_type) { create :notification_type, name: notification_name, auth_mode: auth_mode }
  let(:notification_method) { :email }

  before { create :notification_security_role, notification_type: notification_type, security_role: security_role }

  describe 'notify_user_ids with absolute_user' do
    # remove this on all other apps, division is only in dummy app of rad_common
    subject { notification_class.send(:notify_user_ids, notification_subject, notification_method) }

    let(:notification_name) { 'Notifications::NewDivisionNotification' }
    let(:notification_subject) { create :division, owner: user }
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

  describe 'notify_user_ids with security_roles' do
    subject { notification_class.send(:notify_user_ids, notification_subject, notification_method) }

    let(:notification_name) { 'Notifications::GlobalValidityNotification' }
    let(:notification_subject) { [] }
    let(:auth_mode) { :security_roles }
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
      before { allow(notification_class).to receive(:exclude_user_ids).and_return [user.id] }

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
