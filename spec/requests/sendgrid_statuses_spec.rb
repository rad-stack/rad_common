require 'rails_helper'

describe 'SendgridStatuses' do
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:email) { Faker::Internet.email }
  let(:user_role) { create :security_role, read_attorney: true }
  let(:user) { create :user, security_roles: [user_role] }
  let(:contact_log) { create :contact_log, :email, record: create(:attorney), from_user: user }

  let!(:contact_log_recipient) do
    create :contact_log_recipient, :email, email: email, contact_log: contact_log, to_user: user
  end

  before do
    create :admin
    deliveries.clear
  end

  context 'when raw items are present' do
    let(:params) do
      { _json: [{ event: 'bounce',
                  type: 'block',
                  reason: '500 unknown recipient',
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
      }.to change(contact_log_recipient, :email_status)
        .from('delivered').to('bounce')
        .and change(contact_log_recipient, :sendgrid_reason).from(nil).to('500 unknown recipient')
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
