require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  let(:user) { create :admin }
  let(:search_term) { user.last_name }
  let(:search_results) { JSON.parse(response.body) }

  before { login_as user, scope: :user }

  context 'when scope search' do
    let(:search_scope) { 'user_name' }
    let(:search_path) { "/global_search?term=#{search_term}&global_search_scope=#{search_scope}" }

    xit 'finds a user' do
      get search_path
      expect(search_results[0]['value']).to eq user.to_s
      expect(search_results[0]['id']).to eq user.id
    end

    xit 'shows a search result' do
      get "/global_search_result?global_search_model_name=#{user.class}&global_search_id=#{user.id}"
      expect(response).to redirect_to "/users/#{user.id}"
    end
  end
end
