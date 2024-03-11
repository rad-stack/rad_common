require 'rails_helper'

describe NotificationMailer do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:email) { user.email }
  let(:another_email) { another_user.email }
  let(:last_email) { ActionMailer::Base.deliveries.last }

  before { ActionMailer::Base.deliveries.clear }

  describe '#global_validity' do
    let(:payload) { { error_count: 0, error_messages: [] } }

    context 'with one user' do
      before { described_class.global_validity([user], payload).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with multiple users' do
      before { described_class.global_validity(User.where(id: [user.id, another_user.id]), payload).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.to).to include another_email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with a problem with a link' do
      let(:payload) { { error_count: 1, error_messages: [[user, 'foo bar']] } }

      before { described_class.global_validity([user], payload).deliver_now }

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
        described_class.global_validity([user], payload).deliver_now
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
