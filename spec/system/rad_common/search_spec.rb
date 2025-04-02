require 'rails_helper'

RSpec.describe 'Search', type: :system do
  let(:user) { create :admin }
  let(:division) { create :division }

  before do
    create :admin, user_status: UserStatus.default_inactive_status
    create_list(:user, 3)
    login_as user, scope: :user
  end

  describe 'like filter' do
    it 'displays a text input' do
      visit divisions_path
      expect(page).to have_selector("input[type='text']#search_name_like")
    end

    it 'retains search value after applying filters' do
      visit divisions_path
      fill_in 'search_name_like', with: 'Foo'
      click_button 'Apply Filters'
      expect(page).to have_selector("input[value='Foo']#search_name_like")
    end
  end

  describe 'select filter' do
    before { visit divisions_path }

    unless ENV['CI'] # TODO: this fails on codeship
      it 'displays a select input', :gha_specs_only, :js do
        visit divisions_path
        expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_owner_id']")
        click_bootstrap_select(from: 'search_owner_id')
        expect(page).to have_css('.dropdown-header.optgroup-1 span', text: 'Active')
        expect(page).to have_selector('.dropdown-header.optgroup-2 span', text: 'Inactive')
        expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_division_status']")
      end
    end

    it 'selects a default value', :gha_specs_only, :js do
      selector = ".bootstrap-select .dropdown-toggle[data-id='search_owner_id'] .filter-option-inner-inner"
      expect(page).to have_selector(selector, text: user.to_s)
    end

    it 'retains search value after applying filters' do
      select 'Active', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status').value).to eq Division.division_statuses['status_active'].to_s
    end

    it 'select should have success style when default value is selected' do
      select 'All Statuses', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status')['data-style']).to eq 'btn btn-light'
    end

    it 'select should have warning style when a value is selected other than default' do
      select 'Active', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status')['data-style']).to eq 'btn btn-warning'
    end

    unless ENV['CI']  # TODO: this fails on codeship
      it 'select should have warning style when a value a blank value is selected on filter without default',
         :gha_specs_only, :js do
        expect(page).to have_selector('button[data-id=search_owner_id][class*=btn-light]')
        bootstrap_select 'All Owners', from: 'search_owner_id'
        click_button 'Apply Filters'
        expect(page).to have_selector('button[data-id=search_owner_id][class*=btn-warning]')
      end
    end

    it 'shows required field error' do
      visit divisions_path
      click_button 'Apply Filters'
      expect(page).to have_content 'Status is required'

      select 'Active', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(page).not_to have_content 'Status is required'
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
      fill_in 'search_created_at_start', with: '01/01/2020'
      click_button 'Apply Filters'
      expect(find_field('search_created_at_start').value).to eq '01/01/2020'
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
      expect(page).not_to have_content 'Invalid date entered for created_at'
    end

    it 'does save valid date to users.filter_defaults' do
      visit divisions_path(search: { created_at_start: '2019-12-01', created_at_end: '2019-12-02', division_status: 1 })
      visit '/'
      visit divisions_path
      expect(page.body).to include '2019-12-01'
      expect(page.body).to include '2019-12-02'
    end
  end
end
