require 'rails_helper'

RSpec.describe 'Search Preferences', type: :request do
  let(:user) { create :user }
  let(:search_preference) { create :search_preference, user: user }

  before { login_as user, scope: :user }

  describe 'POST create' do
    let(:valid_attributes) do
      { search_class: 'UserSearch',
        toggle_behavior: 'always_open',
        sticky_filters: false }
    end

    context 'when valid' do
      it 'creates a new search preference' do
        expect {
          post '/search_preferences',
               params: { search_preference: valid_attributes },
               headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.to change(SearchPreference, :count).by(1)
      end

      it 'saves the correct attributes' do
        post '/search_preferences',
             params: { search_preference: valid_attributes },
             headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        preference = SearchPreference.last
        expect(preference.search_class).to eq('UserSearch')
        expect(preference.toggle_behavior).to eq('always_open')
        expect(preference.sticky_filters).to be false
        expect(SearchPreference.last.user).to eq(user)

        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(response.body).to include('search_preference_form')
      end
    end

    context 'when invalid' do
      let(:invalid_attributes) { { search_class: nil, toggle_behavior: 'always_open' } }

      it 'responds with error and does not create a search preference' do
        expect {
          post '/search_preferences',
               params: { search_preference: invalid_attributes },
               headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.not_to change(SearchPreference, :count)
        expect(response).to have_http_status(:unprocessable_content)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end
  end

  describe 'PUT update' do
    let(:valid_update_attributes) { { toggle_behavior: 'always_closed', sticky_filters: false } }

    context 'when user does not own the preference' do
      let(:other_user) { create :user }
      let(:other_preference) { create :search_preference, user: other_user }

      it 'denies access' do
        put "/search_preferences/#{other_preference.id}",
            params: { search_preference: valid_update_attributes },
            headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_update_attributes) { { search_class: nil } }

      it 'does not update the preference' do
        original_search_class = search_preference.search_class

        put "/search_preferences/#{search_preference.id}",
            params: { search_preference: invalid_update_attributes },
            headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        search_preference.reload
        expect(search_preference.search_class).to eq(original_search_class)
        expect(response).to have_http_status(:unprocessable_content)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end
  end
end
