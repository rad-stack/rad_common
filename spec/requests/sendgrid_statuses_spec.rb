require 'rails_helper'

describe 'SendgridStatuses' do
  let(:deliveries) { ActionMailer::Base.deliveries }

  before do
    create :admin
    deliveries.clear
  end

  context 'when raw items are present' do
    let(:params) do
      { _json: [{ event: 'bounce',
                  type: 'block',
                  bounce_classification: 'Reputation',
                  email: Faker::Internet.email,
                  host_name: RadConfig.host_name! }] }
    end

    xit 'notifies' do
      expect {
        post '/sendgrid_statuses', params: params
      }.to change(deliveries, :count).by(1)
    end
  end

  context 'when raw items are not present' do
    let(:params) { { _json: nil } }

    xit 'renders message' do
      post '/sendgrid_statuses', params: params
      expect(response.body).to include 'These are not the droids you are looking for.'
    end
  end
end
