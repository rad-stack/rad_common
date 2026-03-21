require 'rails_helper'

describe RadMailer do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:comma_user) { create :user, first_name: 'Foo,' }
  let(:comma_email) { comma_user.email }
  let(:symbol_user) { create :user, first_name: 'Foo <3' }
  let(:symbol_email) { symbol_user.email }
  let(:email) { user.email }
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:attachment) { { record: division, method: :logo } }

  before { ActionMailer::Base.deliveries.clear }

  describe '#simple_message' do
    let(:recipient) { email }
    let(:division) { create :division, :with_logo }

    before do
      described_class.simple_message(recipient,
                                     'foo',
                                     'bar',
                                     attachment: attachment,
                                     contact_log_record: division).deliver_now
    end

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

      context 'when user has comma in name' do
        let(:recipient) { comma_user }

        it { is_expected.to eq [comma_email] }
      end

      context 'when user has symbol in name' do
        let(:recipient) { symbol_user }

        it { is_expected.to eq [symbol_email] }
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

      it 'creates contact log' do
        expect(ContactLog.count).to eq 1
        expect(ContactLogRecipient.count).to eq 1
        expect(ContactLog.last.record).to eq division
      end
    end

    describe 'attachment' do
      subject { last_email.attachments.count }

      it { is_expected.to eq 1 }
    end

    describe 'raw file attachment' do
      subject { last_email.attachments.count }

      let(:attachment) { { raw_file: 'foo', filename: 'bar', content_type: 'baz' } }

      it { is_expected.to eq 1 }
    end

    describe 'contact logs' do
      it 'creates a contact log' do
        expect(ContactLog.count).to eq 1
        expect(ContactLogRecipient.count).to eq 1
      end

      it 'sets to user if email matches' do
        expect(ContactLogRecipient.last.to_user).to eq user
      end

      context 'when user is inactive' do
        let(:inactive_user) { create :user, :inactive }
        let(:recipient) { inactive_user.email }

        it 'does not set to_user' do
          expect(ContactLogRecipient.last.to_user).to be_nil
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
