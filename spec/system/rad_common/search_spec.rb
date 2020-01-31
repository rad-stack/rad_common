require 'rails_helper'

RSpec.describe 'Search', type: :system do
  let(:user) { create :admin }
  let!(:inactive_user) { create(:admin, user_status: UserStatus.default_inactive_status) }
  let(:division) { create :division }

  before do
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

    it 'displays a select input', js: true do
      visit divisions_path
      expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_owner_id']")
      click_bootstrap_select(from: 'search_owner_id')
      expect(page).to have_css('.dropdown-header.optgroup-1 span', text: 'Active')
      expect(page).to have_selector('.dropdown-header.optgroup-2 span', text: 'Inactive')
      expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_division_status']")
    end

    it 'selects a default value', js: true do
      expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_owner_id'] .filter-option-inner-inner", text: user.to_s)
    end

    it 'retains search value after applying filters' do
      select 'Active', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status').value).to eq Division.division_statuses['status_active'].to_s
    end

    it 'select should have success style when default value is selected' do
      select 'All Statuses', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status')['data-style']).to eq 'btn btn-success'
    end

    it 'select should have warning style when a value is selected other than default' do
      select 'Active', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status')['data-style']).to eq 'btn btn-warning'
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
  end
end
