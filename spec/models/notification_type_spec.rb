require 'rails_helper'

RSpec.describe NotificationType do
  let(:user) { create :admin, mobile_phone: mobile_phone }
  let(:mobile_phone) { create :phone_number, :mobile }
  let(:another_user) { create :user }
  let(:notification_type) { Notifications::DivisionUpdatedNotification.main(notification_payload) }

  let(:division) do
    Audited.audit_class.as_user(another_user) do
      create :division, owner: user
    end
  end

  let(:notification_payload) { division }
  let(:notification_method) { :email }

  describe 'enabled_for_method? when notification settings not present' do
    subject(:result) { notification_type.send(:enabled_for_method?, user.id, notification_method) }

    before do
      allow(RadConfig).to receive(:twilio_enabled?).and_return true
      allow_any_instance_of(PhoneNumberValidator).to receive(:check_twilio?).and_return false
      allow_any_instance_of(described_class).to receive(:default_notification_methods).and_return(default_methods)
    end

    context 'when default method is email' do
      let(:default_methods) { [:email] }

      context 'when notification method is email' do
        let(:notification_method) { :email }

        it { is_expected.to be true }
      end

      context 'when notification method is sms' do
        let(:notification_method) { :sms }

        it { is_expected.to be false }
      end
    end

    context 'when default method is email + sms' do
      let(:default_methods) { %i[email sms] }

      context 'when notification method is email' do
        let(:notification_method) { :email }

        it { is_expected.to be true }
      end

      context 'when notification method is sms' do
        let(:notification_method) { :sms }

        context 'without Twilio enabled' do
          before { allow(RadConfig).to receive(:twilio_enabled?).and_return false }

          it { is_expected.to be false }
        end

        context 'when user has mobile phone' do
          it { is_expected.to be true }
        end

        context "when user doesn't have mobile phone" do
          let(:mobile_phone) { nil }

          before { allow_any_instance_of(UserStatus).to receive(:validate_email_phone?).and_return false }

          it { is_expected.to be false }
        end
      end

      context 'when default method is sms' do
        let(:default_methods) { [:sms] }

        context 'when notification method is email' do
          let(:notification_method) { :email }

          it { expect { result }.to raise_error 'default_notification_methods must include :email' }
        end

        context 'when notification method is sms' do
          let(:notification_method) { :sms }

          it { expect { result }.to raise_error 'default_notification_methods must include :email' }
        end
      end
    end
  end

  describe 'contact_log' do
    let(:contact_log) { ContactLog.last }

    context "when notification has it's own mailer" do
      before { Notifications::UserWasApprovedNotification.main([another_user, user]).notify! }

      it 'sets contact_log record and contact_log from_user' do
        expect(contact_log.record).to eq another_user
        expect(contact_log.from_user).to eq user
      end
    end

    context 'when notification uses simpler mailer' do
      before { Notifications::DuplicateFoundUserNotification.main(division).notify! }

      it 'sets contact_log record and contact_log from_user' do
        expect(contact_log.record).to eq division
        expect(contact_log.from_user).to eq another_user
      end
    end
  end

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

      it { expect { result }.to raise_error "absolute users must be active: [#{user.id}]" }
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
