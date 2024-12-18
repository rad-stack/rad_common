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
      selector = ".bootstrap-select .dropdown-toggle[data-id='search_owner_id'] .filter-option-inner-inner"
      expect(page).to have_selector(selector, text: user.to_s)
    end

    it 'retains search value after applying filters' do
      first('#search_division_status').select('Active')
      first('button', text: 'Apply Filters').click
      expect(first('#search_division_status').value).to eq [Division.division_statuses['status_active'].to_s]
    end

    it 'select should have success style when default value is selected' do
      first('#search_division_status').select('All Statuses')
      first('button', text: 'Apply Filters').click
      expect(first('#search_division_status')['data-style']).to eq 'btn btn-light'
    end

    it 'select should have warning style when a value is selected other than default', :js do
      bootstrap_select 'Inactive', from: 'search_division_status'
      find('body').click
      first('button', text: 'Apply Filters').click
      expect(first('button[data-id="search_division_status"]')['class']).to include 'btn btn-warning'
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

        # Full Search
        bootstrap_select category.name, from: 'search_category_id', search: category.name
        first('button', text: 'Apply Filters').click
        expect(page).to have_content(division.name)
        expect(page).to have_no_content(other_division.name)

        # Partial Search
        bootstrap_select other_category.name, from: 'search_category_id', search: 'App'
        first('button', text: 'Apply Filters').click
        expect(page).to have_content(other_division.name)
      end

      context 'when exclude is checked' do
        it 'filters out selected options' do
          first('button', text: 'Apply Filters').click

          expect(page).to have_content(division.name)
          expect(page).to have_content(other_division.name)

          bootstrap_select category.name, from: 'search_category_id', search: category.name
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

    it 'does save valid date to users.filter_defaults' do
      visit divisions_path(search: { created_at_start: '2019-12-01', created_at_end: '2019-12-02', division_status: 1 })
      visit '/'
      visit divisions_path
      expect(page.body).to include '2019-12-01'
      expect(page.body).to include '2019-12-02'
    end

    it 'allows using pre-defined date ranges', :js do
      within('[data-controller="search-date-filter"]') do
        find_by_id('date-range-dropdown').click
        find('a', text: 'This Month').click
      end
      first('button', text: 'Apply Filters').click

      expect(find_by_id('search_created_at_start').value).to eq Date.current.beginning_of_month.strftime('%Y-%m-%d')
      expect(find_by_id('search_created_at_end').value).to eq Date.current.end_of_month.strftime('%Y-%m-%d')

      within('[data-controller="search-date-filter"]') do
        find_by_id('date-range-dropdown').click
        find('a', text: 'Clear').click
      end
      first('button', text: 'Apply Filters').click

      expect(find_by_id('search_created_at_start').value).to eq ''
      expect(find_by_id('search_created_at_end').value).to eq ''
    end
  end
end
