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
      before { RadbearMailer.global_validity([user], []).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end

    context 'with multiple users' do
      before { RadbearMailer.global_validity(User.where(id: [user.id, another_user.id]), []).deliver_now }

      it 'matches as expected' do
        expect(last_email.subject).to include 'Invalid data in'
        expect(last_email.to).to include email
        expect(last_email.to).to include another_email
        expect(last_email.body.encoded).to include('There are 0 invalid records')
      end
    end
  end

  describe '#simple_message' do
    let(:recipient) { email }

    before { RadbearMailer.simple_message(recipient, 'foo', 'bar').deliver_now }

    describe 'subject' do
      subject { last_email.subject }
      it { is_expected.to eq 'foo' }
    end

    describe 'to' do
      subject { last_email.to }

      context 'to an email address' do
        it { is_expected.to eq [email] }
      end

      context 'to a user' do
        let(:recipient) { user }
        it { is_expected.to eq [email] }
      end

      context 'to multiple users' do
        let(:recipient) { [user.id, another_user.id] }

        it { is_expected.to include user.email }
        it { is_expected.to include another_user.email }
      end
    end
  end

  describe '#email_report' do
    let(:csv) { CSV.generate { '' } }
    let(:report_name) { 'Sample Report' }
    let(:start_date) { Time.zone.now }
    let(:end_date) { Time.zone.now }
    let(:options) { { start_date: start_date, end_date: end_date } }

    before { RadbearMailer.email_report(user, csv, report_name, options).deliver_now }

    it 'emails a csv report' do
      expect(last_email.subject).to include('Sample Report')
      expect(last_email.to_s).to include('Attached is the')
      expect(last_email.attachments.first.content_type).to eq('text/csv')
    end
  end
end
