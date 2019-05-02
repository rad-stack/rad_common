require 'rails_helper'

describe 'Searches', type: :request do
  let(:admin) { create :admin }

  describe 'searches' do
    before do
      login_as(admin, scope: :user)
    end

    context 'scope search' do
      it 'finds a user' do
        visit "/rad_common/global_search?term=#{admin.first_name}"
        expect(page).to have_content admin.first_name
        expect(page).to have_content admin.last_name
        expect(page).to have_content admin.id
      end

      it 'shows a search result' do
        visit "/rad_common/global_search_result?global_search_model_name=#{admin.class}&global_search_id=#{admin.id}"

        expect(page).to have_content admin.email
        expect(page).to have_content admin.first_name
        expect(page).to have_content admin.last_name
      end

      it 'can search with a compound data scope' do
        visit "/rad_common/global_search?term=#{admin.first_name}&global_search_scope=user_name"
        expect(page).to have_content admin.first_name
        expect(page).to have_content admin.last_name
        expect(page).to have_content admin.id
      end

      it 'can search with a compound data scope with no where scope' do
        visit "/rad_common/global_search?term=#{admin.first_name}&global_search_scope=user_name_with_no_where"
        expect(page).to have_content admin.first_name
        expect(page).to have_content admin.last_name
        expect(page).to have_content admin.id
      end
    end

    context 'super search' do
      let(:term) { 'Peters' }
      let!(:user) { create(:user, last_name: term) }
      let!(:division) { create(:division, name: term) }
      let(:prompt) { 'Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal query is preferred to get your results quickly and not bog down the system' }

      it 'can search for results across multiple tables' do
        visit "rad_common/global_search?term=#{term}&super_search=1"
        expect(page).to have_content(user.id)
        expect(page).to have_content(division.id)
        expect(page).to have_content('User')
        expect(page).to have_content('Division')
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
