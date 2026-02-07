require 'rails_helper'

RSpec.describe 'ApiLogs' do
  let(:user) { create :admin }
  let(:api_log) { create :api_log }

  before { login_as user, scope: :user }

  describe 'GET index' do
    it 'returns a successful response' do
      api_log
      get '/api_logs'
      expect(response).to be_successful
    end
  end

  describe 'GET show' do
    it 'returns a successful response' do
      get "/api_logs/#{api_log.id}"
      expect(response).to be_successful
    end
  end
end
