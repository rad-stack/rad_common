require 'rails_helper'

describe 'Searches', type: :request do
  let(:admin) { create :admin }
  let(:search_results) { JSON.parse(response.body) }

  describe 'searches' do
    before do
      login_as(admin, scope: :user)
    end

    context 'scope search' do
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

    context 'super search' do
      let(:term) { 'Peters' }
      let!(:user) { create(:user, last_name: term) }
      let!(:division) { create(:division, name: term) }
      let(:prompt) { 'Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal query is preferred to get your results quickly and not bog down the system' }

      it 'can search for results across multiple tables' do
        get "/rad_common/global_search?term=#{term}&super_search=1"
        expect(search_results[0]['model_name']).to eq 'User'
        expect(search_results[0]['id']).to eq user.id
        expect(search_results[1]['model_name']).to eq 'Division'
      end

      context 'asks the user if they want to use' do
        it 'clears checkbox if dismissed', js: true do
          visit '/'
          page.dismiss_confirm prompt do
            check 'super_search'
          end
          expect(find('#global_search_name')[:placeholder]).to eq 'Search for user by name'
        end

        it 'uses if confirmed', js: true do
          visit '/'
          page.accept_confirm prompt do
            check 'super_search'
          end
          expect(find('#global_search_name')[:placeholder]).to eq 'Super Search'
        end
      end
    end
  end
end
