require 'rails_helper'

describe FirebaseLogDestroyJob do
  let(:client) { FirebaseApp.new.client }
  let(:user) { create :admin }
  let(:log_id) { 'registrations' }
  let(:error_log_key) { '4RnyUxuF2zNQR4CMzb13ONeEGlV2' }
  let(:logs) { client.get("logs/#{log_id}") }

  let(:data) do
    { registrations: { "#{error_log_key}": { email: Faker::Internet.email,
                                             timestamp: '2018-12-30 15:07:27 UTC',
                                             error: 'this is an error message' },
                       'duKKgpUf9nbSgzzifpAxqJ2m6CZ2': { email: Faker::Internet.email,
                                                         timestamp: '2018-12-30 15:07:27 UTC' } } }
  end

  before { client.update('logs', data) }

  it 'destroys all logs in category' do
    type = 'all'
    expect(logs.body.length).to eq(2)
    described_class.perform_now(type, log_id, user.id)
    logs = client.get("logs/#{log_id}")
    expect(logs.body).to eq(nil)
  end

  it 'destroys non error logs in category' do
    type = 'non_errors'

    expect(logs.body.length).to eq(2)
    expect(logs.body[error_log_key]['error']).to eq('this is an error message')

    described_class.perform_now(type, log_id, user.id)

    logs = client.get("logs/#{log_id}")
    expect(logs.body.length).to eq(1)
    expect(logs.body[error_log_key]['error']).to eq('this is an error message')
  end

  it 'sends a failure message if no response' do
    type = 'all'
    allow_any_instance_of(Firebase::Response).to receive(:success?).and_return(false)
    described_class.perform_now(type, log_id, user.id)
    expect(ActionMailer::Base.deliveries.last.subject).to include('Firebase error')
  end
end
