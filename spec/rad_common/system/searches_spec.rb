require 'rails_helper'

RSpec.describe 'Searches', type: :system do
  let(:admin) { create :admin }
  let(:search_results) { JSON.parse(response.body) }

  before { login_as admin, scope: :user }

  context 'with super search', :js do
    let(:term) { 'Peters' }

    let(:prompt) do
      'Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal ' \
        'query is preferred to get your results quickly and not bog down the system'
    end

    before { create(:user, last_name: term) }

    context 'when super search is enabled' do
      before { allow(RadConfig).to receive(:enable_super_search?).and_return(true) }

      context 'when asking the user if they want to use' do
        it 'clears checkbox if dismissed' do
          visit '/'
          expect(page).to have_css 'input.super_search'
          page.dismiss_confirm prompt do
            check 'super_search'
          end
          expect(first('.global_search_name', match: :first)[:placeholder]).to eq 'Search user by name'
        end

        it 'uses if confirmed' do
          visit '/'
          expect(page).to have_css 'input.super_search'
          page.accept_confirm prompt do
            check 'super_search'
          end
          expect(first('.global_search_name')[:placeholder]).to eq 'Super Search'
        end
      end
    end

    context 'when super search is not enabled' do
      before { allow(RadConfig).to receive(:enable_super_search?).and_return(false) }

      it 'does not have a super search option' do
        visit '/'
        expect(page).not_to have_css 'input.super_search'
      end
    end
  end
end
