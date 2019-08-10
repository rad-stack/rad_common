require 'rails_helper'

RSpec.describe 'Divisions', type: :system do
  let(:user) { create :admin }
  let(:division) { create :division }

  before do
    login_as(user, scope: :user)
  end

  describe 'new' do
    it 'renders the new template' do
      visit new_division_path
      expect(page).to have_content('New Division')
    end

    it 'shows presence error on autocomplete field' do
      visit new_division_path
      click_button 'Save'
      expect(page).to have_content('must exist')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_division_path(division)
      expect(page).to have_content('Editing Division')
    end

    it 'displays error for owner field when blank', js: true do
      visit edit_division_path(division)
      fill_in 'owner_name', with: ''
      click_button 'Save'

      if ENV['CI']
        # TODO: fix this so it works locally
        expect(page).to have_content 'must exist and can\'t be blank'
      end
    end
  end

  describe 'index' do
    it 'displays the divisions' do
      division
      visit divisions_path
      expect(page).to have_content(division.to_s)
    end
  end

  describe 'show' do
    before { visit division_path(division) }

    it 'shows the division' do
      expect(page).to have_content(division.to_s)
    end

    it 'shows the right actions' do
      expect(page).to have_content('Right Button')
    end
  end
end
