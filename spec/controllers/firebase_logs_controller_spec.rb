require 'rails_helper'

describe FirebaseLogsController do
  let(:admin) { create :admin }

  before do
    sign_in admin
  end

  it 'retrieves all available firebase logs' do
    get :index
    expect(assigns(:firebase_logs).first.first).to eq('registrations')
  end

  it 'destroy events' do
    allow_any_instance_of(FirebaseLogDestroyJob).to receive(:perform).and_return(nil)
    @request.env['HTTP_REFERER'] = firebase_logs_path
    delete :destroy, params: { id: 'events', type: 'all' }
    expect(response).to redirect_to(firebase_logs_path)
  end
end
