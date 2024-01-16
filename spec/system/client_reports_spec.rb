require 'rails_helper'

RSpec.describe 'ClientReports' do
  let(:user) { create :admin }
  let(:report_date) { 5.days.ago }
  let!(:client) { create :client, created_at: report_date }

  before { login_as user, scope: :user }

  it 'displays the report' do
    visit client_reports_path(report: { start_date: report_date, end_date: report_date })

    expect(page).to have_content(client.to_s)
  end

  it 'displays an error when applicable' do
    visit client_reports_path(report: { start_date: report_date, end_date: report_date.advance(days: -10) })

    expect(page).to have_content('Start date must be before end date')
  end
end
