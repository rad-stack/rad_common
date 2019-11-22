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
    it 'displays a select input', js: true do
      visit divisions_path
      expect(page).to have_selector(".bootstrap-select .dropdown-toggle[data-id='search_owner_id']")
    end

    xit 'retains search value after applying filters', js: true do
      visit divisions_path
      bootstrap_select User.first.to_s, from: 'search_owner_id'
      click_button 'Apply Filters'
    end
    it 'select should have success style when default value is selected'
    it 'select should have warning style when a value is selected other than default'
  end

  describe 'date filter' do
    it 'should display a start and end inputs'
    it 'should retain search value after applying filters'\
  end
end
