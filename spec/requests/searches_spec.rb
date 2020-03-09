require 'rails_helper'

describe 'Searches', type: :request do
  let(:user) { create :admin }
  let(:search_term) { user.last_name }
  let(:search_results) { JSON.parse(response.body) }

  before { login_as user, scope: :user }

  context 'when scope search' do
    context 'with user_name_with_no_where scope' do
      let(:search_scope) { 'user_name_with_no_where' }
      let(:search_path) { "/rad_common/global_search?term=#{search_term}&global_search_scope=#{search_scope}" }

      it 'can search with a compound data scope with no where scope' do
        # remove this test on apps that do not have the 'user_name_with_no_where' scope
        get search_path
        expect(search_results[0]['value']).to eq user.to_s
        expect(search_results[0]['id']).to eq user.id
      end
    end
  end

  context 'when super search' do
    let(:search_path) { "/rad_common/global_search?term=#{search_term}&super_search=1" }
    let!(:division) { create :division, name: search_term }

    it 'can search for results across multiple tables' do
      get search_path

      expect(search_results[0]['model_name']).to eq 'User'
      expect(search_results[0]['id']).to eq user.id
      expect(search_results[1]['model_name']).to eq 'Division'
      expect(search_results[1]['id']).to eq division.id
    end
  end
end
