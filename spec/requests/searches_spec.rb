require 'rails_helper'

describe 'Searches', type: :request do
  let(:admin) { create :admin }
  let(:search_results) { JSON.parse(response.body) }

  describe 'searches' do
    before { login_as admin, scope: :user }

    context 'when scope search' do
      it 'finds a user' do
        get "/rad_common/global_search?term=#{admin.first_name}"
        expect(search_results[0]['value']).to eq admin.to_s
        expect(search_results[0]['id']).to eq admin.id
      end

      it 'shows a search result' do
        get "/rad_common/global_search_result?global_search_model_name=#{admin.class}&global_search_id=#{admin.id}"
        expect(response).to redirect_to "/users/#{admin.id}"
      end

      it 'can search with a compound data scope' do
        get "/rad_common/global_search?term=#{admin.first_name}&global_search_scope=user_name"
        expect(search_results[0]['value']).to eq admin.to_s
        expect(search_results[0]['id']).to eq admin.id
      end

      it 'can search with a compound data scope with no where scope' do
        get "/rad_common/global_search?term=#{admin.first_name}&global_search_scope=user_name_with_no_where"
        expect(search_results[0]['value']).to eq admin.to_s
        expect(search_results[0]['id']).to eq admin.id
      end
    end

    context 'when super search' do
      let(:term) { 'Peters' }
      let!(:user) { create(:user, last_name: term) }

      it 'can search for results across multiple tables' do
        create :division, name: term

        get "/rad_common/global_search?term=#{term}&super_search=1"
        expect(search_results[0]['model_name']).to eq 'User'
        expect(search_results[0]['id']).to eq user.id
        expect(search_results[1]['model_name']).to eq 'Division'
      end
    end
  end
end
