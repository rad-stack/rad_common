require 'rails_helper'

RSpec.describe 'ClientReports' do
  let(:user) { create :admin }
  let(:report_date) { 5.days.ago }
  let!(:client) { create :client, created_at: report_date }
  let(:params) { { format: :csv, report: { start_date: report_date, end_date: report_date } } }
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:csv_attachment) { last_email.attachments.first }

  before do
    create :client, created_at: report_date
    login_as user, scope: :user
  end

  context 'with CSV' do
    it 'emails the file' do
      get '/client_reports', params: params, headers: { HTTP_REFERER: '/' }
      expect(last_email.subject).to include('Client Report Export')
      expect(csv_attachment.content_type).to start_with('text/csv')
      expect(csv_attachment.read).to include(client.to_s)
    end

    context 'with soft record limit' do
      before { allow_any_instance_of(ClientReportExport).to receive(:soft_record_limit).and_return(1) }

      it 'notifies the user to narrow their search' do
        get '/client_reports', params: params, headers: { HTTP_REFERER: '/' }
        expect(last_email.subject).to eq 'Client Report Export: Limit Exceeded'
      end
    end
  end

  context 'with pdf' do
    xit 'generates a pdf' do
      get '/client_reports', params: { format: 'pdf' }
      expect(response.content_type).to eq('application/pdf')
    end
  end
end
