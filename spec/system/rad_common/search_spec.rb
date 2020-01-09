require 'rails_helper'

RSpec.describe 'Search', type: :system do
  let(:user) { create :admin }
  let(:division) { create :division }

  before { login_as user, scope: :user }

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
      expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_division_status']")
    end

    it 'retains search value after applying filters' do
      select 'Active', from: 'search_division_status'
      click_button 'Apply Filters'
      expect(find_field('search_division_status').value).to eq Division.division_statuses['status_active']
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

    it 'should display a start and end inputs' do
      expect(page).to have_css('#search_created_at_start')
      expect(page).to have_css('#search_created_at_end')
    end

    it 'should retain search value after applying filters' do
      fill_in 'search_created_at_start', with: '01/01/2020'
      click_button 'Apply Filters'
      expect(find_field('search_created_at_start').value).to eq '01/01/2020'
    end
  end
end
