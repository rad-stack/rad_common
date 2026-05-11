require 'rails_helper'

describe NotificationMailer do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:email) { user.email }
  let(:another_email) { another_user.email }
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:notification_type) { Notifications::InvalidDataWasFoundNotification.main }

  before do
    create :admin
    ActionMailer::Base.deliveries.clear
  end

  describe '#new_user_signed_up' do
    let(:new_user) { create :pending }
    let(:notification_type) { Notifications::NewUserSignedUpNotification.main }
    let(:payload) { { user: new_user } }
    let(:internal_user) { create :admin }
    let(:external_user) { create :user, :external }

    context 'with all internal recipients' do
      before do
        described_class.new_user_signed_up(notification_type, [internal_user.id], payload).deliver_now
      end

      it 'includes the edit user link' do
        expect(last_email.to).to include internal_user.email
        expect(last_email.body.encoded).to match(%r{/users/#{new_user.id}/edit})
      end
    end

    context 'with all external recipients' do
      before do
        described_class.new_user_signed_up(notification_type, [external_user.id], payload).deliver_now
      end

      it 'omits the edit user link' do
        expect(last_email.to).to include external_user.email
        expect(last_email.body.encoded).not_to match(%r{/users/\d+/edit})
      end
    end

    context 'with mixed internal and external recipients' do
      it 'raises an error' do
        expect {
          described_class.new_user_signed_up(notification_type,
                                             [internal_user.id, external_user.id],
                                             payload).deliver_now
        }.to raise_error(RuntimeError, /mixed internal and external recipients/)
      end
    end
  end

  describe '#global_validity' do
    let(:payload) { { error_count: 0, error_messages: [] } }

    context 'with one user' do
      before { described_class.global_validity(notification_type, [user], payload).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with multiple users' do
      before do
        described_class.global_validity(notification_type,
                                        User.where(id: [user.id, another_user.id]),
                                        payload).deliver_now
      end

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.to).to include another_email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with a problem with a link' do
      let(:payload) { { error_count: 1, error_messages: [[user, 'foo bar']] } }

      before { described_class.global_validity(notification_type, [user], payload).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There is 1 invalid record')
        expect(last_email.body.encoded).to include("/users/#{user.id}")
      end
    end

    context 'with a problem without a link' do
      let(:notification_setting) do
        create :notification_setting, notification_type: Notifications::InvalidDataWasFoundNotification.main
      end

      let(:payload) { { error_count: 1, error_messages: [[notification_setting, 'foo bar']] } }

      before do
        create :admin
        described_class.global_validity(notification_type, [user], payload).deliver_now
      end

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There is 1 invalid record')
        expect(last_email.body.encoded).to include(notification_setting.to_s)
      end
    end
  end
end
