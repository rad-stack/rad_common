require 'rails_helper'

describe 'SendgridStatuses' do
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:email) { Faker::Internet.email }
  let(:contact_log) { create :contact_log, :email }
  let!(:contact_log_recipient) { create :contact_log_recipient, :email, email: email, contact_log: contact_log }

  before do
    create :admin
    deliveries.clear
  end

  context 'when raw items are present' do
    let(:params) do
      { _json: [{ event: 'bounce',
                  type: 'block',
                  bounce_classification: 'Reputation',
                  email: email,
                  host_name: RadConfig.host_name!,
                  contact_log_id: contact_log.id }] }
    end

    it 'notifies' do
      expect {
        post '/sendgrid_statuses', params: params
      }.to change(deliveries, :count).by(1)
    end

    it 'updates status of contact log' do
      expect {
        post '/sendgrid_statuses', params: params
        contact_log_recipient.reload
      }.to change(contact_log_recipient, :email_status).from('delivered').to('bounce').and change(contact_log_recipient, :bounce_classification).from(nil).to('Reputation')
    end
  end

  context 'when raw items are not present' do
    let(:params) { { _json: nil } }

    it 'renders message' do
      post '/sendgrid_statuses', params: params
      expect(response.body).to include 'These are not the droids you are looking for.'
    end
  end
end
