require 'rails_helper'

describe NotificationMailer, type: :mailer do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:email) { user.email }
  let(:another_email) { another_user.email }
  let(:last_email) { ActionMailer::Base.deliveries.last }

  before { ActionMailer::Base.deliveries.clear }

  describe '#global_validity' do
    context 'with one user' do
      before { described_class.global_validity([user], []).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with multiple users' do
      before { described_class.global_validity(User.where(id: [user.id, another_user.id]), []).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.to).to include another_email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with a problem with a link' do
      before { described_class.global_validity([user], [[user, 'foo bar']]).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There is 1 invalid record')
        expect(last_email.body.encoded).to include("/users/#{user.id}")
      end
    end

    context 'with a problem without a link' do
      let(:notification_setting) do
        create :notification_setting, notification_type: create(:global_validity_notification)
      end

      before { described_class.global_validity([user], [[notification_setting, 'foo bar']]).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There is 1 invalid record')
        expect(last_email.body.encoded).to include(notification_setting.to_s)
      end
    end
  end
end
