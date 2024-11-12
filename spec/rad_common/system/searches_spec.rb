require 'rails_helper'

RSpec.describe 'Searches', type: :system do
  let(:admin) { create :admin }
  let(:search_results) { JSON.parse(response.body) }

  before { login_as admin, scope: :user }

  context 'with super search' do
    let(:term) { 'Peters' }

    let(:prompt) do
      'Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal ' \
        'query is preferred to get your results quickly and not bog down the system'
    end

    before { create :user, last_name: term }

    context 'when asking the user if they want to use' do
      it 'clears checkbox if dismissed', :js, :non_react_specs do
        visit '/'
        page.dismiss_confirm prompt do
          check 'super_search'
        end
        expect(first('.global_search_name', match: :first)[:placeholder]).to eq 'Search user by name'
      end

      it 'uses if confirmed', :js, :non_react_specs do
        visit '/'
        page.accept_confirm prompt do
          check 'super_search'
        end
        expect(first('.global_search_name')[:placeholder]).to eq 'Super Search'
      end
    end
  end
end
