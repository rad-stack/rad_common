require 'rails_helper'

RSpec.describe 'Search' do
  let(:user) { create :admin }
  let(:division) { create :division }

  before do
    create :admin, user_status: UserStatus.default_inactive_status
    create_list :user, 3
    login_as user, scope: :user
  end

  describe 'like filter' do
    it 'displays a text input' do
      visit divisions_path
      expect(page).to have_css("input[type='text']#search_name_like")
    end

    it 'retains search value after applying filters' do
      visit divisions_path
      first('#search_name_like').fill_in(with: 'Foo')
      first('button', text: 'Apply Filters').click
      expect(page).to have_css("input[value='Foo']#search_name_like")
    end

    context 'with name not matching column name' do
      it 'queries specified column' do
        visit '/audits'
        first('#search_audited_changes_like').fill_in(with: 'query')
        first('button', text: 'Apply Filters').click
        expect(current_url).to include('search[audited_changes_like]=query')
      end
    end
  end

  describe 'select filter' do
    before { visit divisions_path }

    it 'selects a default value', :js do
      within '.search_division_status' do
        expect(find('.has-items')).to be_present
      end
    end

    it 'retains search value after applying filters' do
      first('#search_division_status').select('Active')
      first('button', text: 'Apply Filters').click
      expect(first('#search_division_status').value).to eq [Division.division_statuses['status_active'].to_s]
    end

    it 'select should have warning style when a value is selected other than default', :js do
      tom_select 'Inactive', from: 'search_division_status'
      expect(page).to have_no_css('.filter-active .ts-control')
      find('body').click
      first('button', text: 'Apply Filters').click
      expect(page).to have_css('.filter-active .ts-control')
    end

    context 'when ajax select', :js do
      let(:category) { create :category, name: 'Appliance' }
      let(:other_category) { create :category, name: 'Applications' }
      let!(:other_division) { create :division, category: other_category, owner: user }

      before do
        division.update!(category: category, owner: user)
      end

      it 'allows searching and selecting filter option' do
        first('button', text: 'Apply Filters').click

        expect(page).to have_content(division.name)
        expect(page).to have_content(other_division.name)

        # Without Search max options not exceeded
        tom_select category.name, from: 'search_category_id'
        first('button', text: 'Apply Filters').click
        expect(page).to have_content(division.name)
        expect(page).to have_no_content(other_division.name)

        create_list :category, 300
        visit divisions_path

        # Full Search
        tom_select category.name, from: 'search_category_id', search: category.name
        first('button', text: 'Apply Filters').click
        expect(page).to have_content(division.name)
        expect(page).to have_no_content(other_division.name)

        # Partial Search
        tom_select other_category.name, from: 'search_category_id', search: 'App'
        first('button', text: 'Apply Filters').click
        expect(page).to have_content(other_division.name)
      end

      context 'when exclude is checked' do
        it 'filters out selected options' do
          first('button', text: 'Apply Filters').click

          expect(page).to have_content(division.name)
          expect(page).to have_content(other_division.name)

          tom_select category.name, from: 'search_category_id', search: category.name
          first('button', text: 'Apply Filters').click
          expect(page).to have_content(division.name)
          expect(page).to have_no_content(other_division.name)

          first('#search_category_id_not').check
          first('button', text: 'Apply Filters').click

          expect(page).to have_no_content(division.name)
          expect(page).to have_content(other_division.name)
        end
      end
    end

    it 'shows required field error' do
      visit divisions_path(search: { division_status: [''] })
      first('button', text: 'Apply Filters').click
      expect(page).to have_content 'Status is required'

      visit divisions_path(search: { division_status: [Division.division_statuses[:status_active]] })
      expect(page).to have_no_content 'Status is required'
    end
  end

  describe 'date filter' do
    before { visit divisions_path }

    it 'displays a start and end inputs' do
      expect(page).to have_css('#search_created_at_start')
      expect(page).to have_css('#search_created_at_end')
    end

    it 'allows for start and end input label overrides' do
      expect(page).to have_content 'Division Created At Start'
      expect(page).to have_content 'Division Created At End'
    end

    it 'retains search value after applying filters' do
      first('#search_created_at_start').fill_in(with: '01/01/2020')
      first('button', text: 'Apply Filters').click
      expect(first('#search_created_at_start').value).to eq '01/01/2020'
    end

    it 'displays error message when invalid date entered' do
      visit divisions_path(search: { created_at_start: '2019-13-01', created_at_end: '2019-12-02' })
      expect(page).to have_content 'Invalid date entered for created_at'
    end

    it 'does not save invalid date to users.filter_defaults' do
      visit divisions_path(search: { created_at_start: '2019-13-01', created_at_end: '2019-12-02' })
      expect(page).to have_content 'Invalid date entered for created_at'
      visit '/'
      visit divisions_path
      expect(page).to have_no_content 'Invalid date entered for created_at'
    end

    it 'does save valid date to users.filter_defaults', :js do
      create :search_preference, user: user, search_class: 'divisions_search', sticky_filters: true
      visit divisions_path(search: { created_at_start: '2019-12-01', created_at_end: '2019-12-02',
                                     division_status: [1] })
      visit '/'
      visit divisions_path
      expect(page.body).to include '2019-12-01'
      expect(page.body).to include '2019-12-02'
    end
  end

  describe 'search preferences modal', :js do
    before { visit divisions_path }

    it 'displays the preference form in the modal' do
      if ENV['CI']
        find('button[title="Filter Settings"]').click
        within '#filter-settings-modal' do
          expect(page).to have_content('Toggle Filters Behavior')
          expect(page).to have_content('Remember Filter Values')
          expect(page).to have_button('Save')
        end
      end
    end
  end

  describe 'toggle behavior settings', :js do
    context 'with always_open behavior' do
      it 'shows filters by default when visiting the page' do
        create :search_preference, user: user,
                                   search_class: 'divisions_search',
                                   toggle_behavior: 'always_open'
        visit divisions_path
        expect(page).to have_css('#search-filter-collapse.show')
      end
    end

    context 'with always_closed behavior' do
      it 'hides filters by default when visiting the page' do
        create :search_preference, user: user,
                                   search_class: 'divisions_search',
                                   toggle_behavior: 'always_closed'
        visit divisions_path
        expect(page).to have_css('#search-filter-collapse', visible: :hidden)
        expect(page).to have_no_css('#search-filter-collapse.show', visible: :all)
      end
    end

    context 'with remember_state behavior' do
      it 'shows filters by default on first visit' do
        create :search_preference, user: user,
                                   search_class: 'divisions_search',
                                   toggle_behavior: 'remember_state'
        visit divisions_path
        expect(page).to have_css('#search-filter-collapse.show')
        expect(page.find('[href="#search-filter-collapse"]')[:class]).not_to include 'collapsed'
        page.find('[href="#search-filter-collapse"]').click
        expect(page.find('[href="#search-filter-collapse"]')[:class]).to include 'collapsed'
        expect {
          Timeout.timeout(1) do
            loop until page.evaluate_script(
              "localStorage.getItem('filter-collapse-divisions_search')"
            ) == 'hidden'
          end
        }.not_to raise_error

        visit users_path
        visit divisions_path
        expect(page).to have_css('[href="#search-filter-collapse"]')
        expect(page).to have_no_css('#search-filter-collapse.show')
      end
    end
  end

  describe 'applying settings from modal', :js do
    it 'creates and applies new preferences' do
      if ENV['CI']
        visit divisions_path

        expect(page).to have_css('#search-filter-collapse.show')

        find('button[title="Filter Settings"]').click
        within '#filter-settings-modal' do
          select 'Always Closed', from: 'search_preference_toggle_behavior'
          click_button 'Save'
        end

        expect(page).to have_no_css('#search-filter-collapse.show', visible: :all)
        visit users_path
        visit divisions_path
        expect(page).to have_css('[href="#search-filter-collapse"]')
        expect(page).to have_no_css('#search-filter-collapse.show', visible: :all)
      end
    end

    it 'updates existing preferences' do
      if ENV['CI']
        create :search_preference, user: user,
                                   search_class: 'divisions_search',
                                   toggle_behavior: 'always_closed',
                                   sticky_filters: false

        visit divisions_path

        expect(page).to have_css('[href="#search-filter-collapse"]')
        expect(page).to have_no_css('#search-filter-collapse.show', visible: :all)

        find('button[title="Filter Settings"]').click
        within '#filter-settings-modal' do
          select 'Always Open', from: 'search_preference_toggle_behavior'
          click_button 'Save'
        end
        expect(page).to have_css('#search-filter-collapse.show')
        visit users_path
        visit divisions_path
        expect(page).to have_css('#search-filter-collapse.show')
      end
    end

    it 'enables sticky filters and persists values' do
      if ENV['CI']
        visit divisions_path

        find('button[title="Filter Settings"]').click
        within '#filter-settings-modal' do
          check 'search_preference_sticky_filters'
          click_button 'Save'
        end

        visit divisions_path

        tom_select 'Inactive', from: 'search_division_status'
        find('body').click
        first('button', text: 'Apply Filters').click

        visit root_path
        visit divisions_path

        within '.search_division_status' do
          expect(page).to have_content('Inactive')
        end
      end
    end

    it 'disables sticky filters and clears persistence' do
      if ENV['CI']
        create :search_preference, user: user,
                                   search_class: 'divisions_search',
                                   sticky_filters: true

        visit divisions_path

        tom_select 'Inactive', from: 'search_division_status'
        find('body').click
        first('button', text: 'Apply Filters').click

        find('button[title="Filter Settings"]').click
        within '#filter-settings-modal' do
          uncheck 'search_preference_sticky_filters'
          click_button 'Save'
        end

        visit root_path
        visit divisions_path

        within '.search_division_status' do
          expect(page).to have_no_content('Inactive')
        end
      end
    end
  end
end
