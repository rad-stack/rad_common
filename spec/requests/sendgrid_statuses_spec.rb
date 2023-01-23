require 'rails_helper'

describe 'SendgridStatuses' do
  let(:deliveries) { ActionMailer::Base.deliveries }

  let(:params) do
    { _json: [{ event: 'bounce', type: 'block', bounce_classification: 'Reputation', email: Faker::Internet.email }] }
  end

  before do
    create :admin
    ActionMailer::Base.deliveries.clear
  end

  context 'when raw items are present' do
    it 'notifies' do
      expect {
        post '/sendgrid_statuses', params: params
      }.to change(deliveries, :count).by(1)
    end
  end

  context 'when raw items are not present' do
    it 'renders message' do
      params[:_json] = nil
      post '/sendgrid_statuses', params: params
      expect(response.body).to include 'These are not the droids you are looking for.'
    end
  end
end
