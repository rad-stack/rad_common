require 'rails_helper'
require 'csv'

describe RadbearMailer, type: :mailer do
  describe "simple message" do
    it "message should match expected" do
      email = Faker::Internet.email
      mail = RadbearMailer.simple_message(Company.main, email, "foo", "bar")
      expect(mail.subject).to include "foo"
      expect(mail.to).to include email
    end
  end

  describe 'csv report' do
    let(:user) { create :user }
    it 'emails a csv report' do
      csv         = CSV.generate { '' }
      report_name = 'Sample Report'
      start_date  = DateTime.current
      end_date    = DateTime.current
      options     = { start_date: start_date, end_date: end_date }

      RadbearMailer.email_report(user, csv, report_name, options).deliver_now
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.subject).to include('Sample Report')
      expect(last_email.to_s).to include('Attached is the')
      expect(last_email.attachments.first.content_type).to eq('text/csv')
    end
  end
end
