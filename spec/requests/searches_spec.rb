require 'rails_helper'

describe 'Searches' do
  let(:user) { create :admin }
  let(:search_term) { user.last_name }
  let(:search_results) { response.parsed_body }

  before { login_as user, scope: :user }

  context 'when super search' do
    let(:search_path) { "/global_search?term=#{search_term}&super_search=1" }
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
