require 'rails_helper'

RSpec.describe 'Robots' do
  context 'when crawling is enabled' do
    before do
      allow(RadConfig).to receive_messages(allow_crawling?: true, always_crawl?: true)
    end

    xit 'responds with a robots.txt' do
      get '/robots.txt'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('User-Agent: *')
      expect(response.body).to include('Disallow:')
      expect(response.body).to include('Allow: /')
    end
  end

  context 'when crawling is disabled' do
    xit 'responds with a robots.txt' do
      get '/robots.txt'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('User-Agent: *')
      expect(response.body).to include('Noindex: /')
    end
  end
end
