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
      let(:placeholders) { RadConfig.global_search_scopes!.pluck(:description) }

      it 'clears checkbox if dismissed', :js, :legacy_asset_specs do
        visit '/'

        page.dismiss_confirm prompt do
          check 'super_search'
        end

        expect(find('[aria-controls="search-ts-dropdown"]')[:placeholder]).not_to eq 'Super Search'
        expect(placeholders).to include(find('[aria-controls="search-ts-dropdown"]')[:placeholder])
      end

      it 'uses if confirmed', :js, :legacy_asset_specs do
        visit '/'

        page.accept_confirm prompt do
          check 'super_search'
        end

        expect(find('[aria-controls="search-ts-dropdown"]')[:placeholder]).to eq 'Super Search'
      end
    end
  end
end
