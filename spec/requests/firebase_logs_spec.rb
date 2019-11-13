require 'rails_helper'

describe 'Firebase Logs', type: :request do
  let(:admin) { create :admin }

  before { login_as admin, scope: :user }

  it 'retrieves all available firebase logs', :vcr do
    get '/firebase_logs'
    expect(response.body).to include 'Registrations'
  end

  it 'destroy events' do
    allow_any_instance_of(FirebaseLogDestroyJob).to receive(:perform).and_return(nil)
    delete '/firebase_logs/events', params: { type: 'all' }, headers: { HTTP_REFERER: firebase_logs_path }
    expect(response).to redirect_to(firebase_logs_path)
  end
end
