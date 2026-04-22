require 'rails_helper'

RSpec.describe 'Saved Search Filters' do
  let(:user) { create :admin }
  let(:saved_search_filter) { create :saved_search_filter, user: user }
  let(:filters) { { name_like_match_type: 'Division' } }
  let(:valid_attributes) do
    { search_class: 'UserSearch',
      name: 'Test Filter',
      search_filters: filters.to_json }
  end

  before { login_as user, scope: :user }

  describe 'POST create' do
    it 'responds with turbo' do
      post saved_search_filters_path, params: { saved_search_filter: valid_attributes },
                                      as: :turbo_stream
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('<turbo-stream action="append" target="saved_search_filter_items">')
    end
  end

  describe 'DELETE destroy' do
    context 'when saved filter user is not the current user' do
      before { saved_search_filter.update!(user: create(:user)) }

      it 'responds with forbidden' do
        delete "/saved_search_filters/#{saved_search_filter.id}", as: :turbo_stream
        expect(response).to have_http_status(:forbidden)
      end
    end

    it 'destroys an existing saved search filter' do
      delete saved_search_filter_path(saved_search_filter), as: :turbo_stream
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('<turbo-stream action="remove" ' \
                                       "target=\"saved_filter_item_#{saved_search_filter.id}\">")
    end
  end
end
