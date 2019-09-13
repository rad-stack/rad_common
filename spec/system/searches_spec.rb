require 'rails_helper'

describe 'Searches', type: :system do
  let(:admin) { create :admin }
  let(:search_results) { JSON.parse(response.body) }

  describe 'searches' do
    before do
      login_as(admin, scope: :user)
    end

    context 'super search' do
      let(:term) { 'Peters' }
      let!(:user) { create(:user, last_name: term) }
      let(:prompt) { 'Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal query is preferred to get your results quickly and not bog down the system' }

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
