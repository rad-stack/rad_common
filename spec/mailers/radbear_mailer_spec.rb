require 'rails_helper'
require 'csv'

describe RadbearMailer, type: :mailer do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:email) { user.email }
  let(:another_email) { another_user.email }
  let(:last_email) { ActionMailer::Base.deliveries.last }

  before { ActionMailer::Base.deliveries = [] }

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

  describe '#simple_message' do
    let(:recipient) { email }

    before { described_class.simple_message(recipient, 'foo', 'bar').deliver_now }

    describe 'subject' do
      subject { last_email.subject }

      it { is_expected.to eq 'foo' }
    end

    describe 'to' do
      subject { last_email.to }

      context 'when to an email address' do
        it { is_expected.to eq [email] }
      end

      context 'when to a user' do
        let(:recipient) { user }

        it { is_expected.to eq [email] }
      end

      context 'when to multiple users' do
        let(:recipient) { [user.id, another_user.id] }

        it { is_expected.to include user.email }
        it { is_expected.to include another_user.email }

        context 'with combination of user ids and email addresses' do
          let(:recipient) { [user.id, 'string_email@example.com'] }

          it { is_expected.to include user.email }
          it { is_expected.to include 'string_email@example.com' }
        end

        context 'with just one user id' do
          let(:recipient) { [user.id] }

          it { is_expected.to eq [user.email] }
        end
      end
    end
  end

  describe '#email_report' do
    let(:csv) { CSV.generate { '' } }
    let(:report_name) { 'Sample Report' }
    let(:start_date) { Time.current }
    let(:end_date) { Time.current }
    let(:options) { { start_date: start_date, end_date: end_date } }

    before { described_class.email_report(user, csv, report_name, options).deliver_now }

    it 'emails a csv report' do
      expect(last_email.subject).to include('Sample Report')
      expect(last_email.to_s).to include('Attached is the')
      expect(last_email.attachments.first.content_type).to eq('text/csv')
    end
  end
end
