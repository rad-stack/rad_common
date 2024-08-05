require 'rails_helper'

RSpec.describe NotificationType do
  let(:user) { create :admin }
  let(:notification_type) { Notifications::DivisionUpdatedNotification.main(notification_payload) }
  let(:division) { create :division, owner: user }
  let(:notification_payload) { division }
  let(:notification_method) { :email }

  describe 'bcc recipient' do
    subject { last_email.bcc }

    let(:last_email) { ActionMailer::Base.deliveries.last }

    before do
      notification_type.update! bcc_recipient: bcc_recipient
      ActionMailer::Base.deliveries.clear
      Notifications::DivisionUpdatedNotification.main(division).notify!
    end

    context 'when enabled' do
      let(:bcc_recipient) { Faker::Internet.email }

      it { is_expected.to eq [bcc_recipient] }
    end

    context 'when disabled' do
      let(:bcc_recipient) { nil }

      it { is_expected.to be_nil }
    end
  end

  describe 'notify_user_ids_opted with absolute_users' do
    subject(:result) { notification_type.send(:notify_user_ids_opted, notification_method) }

    it { is_expected.to eq [user.id] }

    context 'when user opts out' do
      before { create :notification_setting, user: user, notification_type: notification_type, enabled: false }

      it { is_expected.to eq [] }
    end

    context 'with inactive user' do
      before { user.update! user_status: UserStatus.default_inactive_status }

      it { expect { result }.to raise_error 'absolute users must be active' }
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
end
