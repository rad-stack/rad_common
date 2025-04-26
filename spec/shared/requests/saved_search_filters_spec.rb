require 'rails_helper'

RSpec.describe 'Saved Search Filters', type: :request do
  let(:user) { create :admin }
  let(:saved_search_filter) { create :saved_search_filter, user: user }
  let(:valid_attributes) { { name: 'foo' } }
  let(:invalid_attributes) { { name: nil } }

  before { login_as user, scope: :user }

  describe 'DELETE destroy' do
    xit 'destroys the requested saved_search_filter' do
      saved_search_filter
      expect {
        delete "/saved_search_filters/#{saved_search_filter.id}", headers: { HTTP_REFERER: users_path }
      }.to change(SavedSearchFilter, :count).by(-1)
    end

    xit 'redirects to the saved_search_filters list' do
      delete "/saved_search_filters/#{saved_search_filter.id}", headers: { HTTP_REFERER: users_path }
      expect(response).to redirect_to(users_path)
    end

    context 'when saved filter user is not the current user' do
      before { saved_search_filter.update!(user: create(:user)) }

      xit 'redirects to unauthorized' do
        delete "/saved_search_filters/#{saved_search_filter.id}", headers: { HTTP_REFERER: users_path }
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to include('Access Denied')
      end
    end
  end
end
