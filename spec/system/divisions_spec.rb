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

    describe 'attachment validation' do
      let(:file2) { 'spec/test_files/radlogo.jpeg' }

      before do
        visit edit_division_path(division)
        page.attach_file('Avatar', file1)
        page.attach_file('Logo', file2)
        click_on 'Save'
      end

      context 'both invalid' do
        let(:file1) { 'spec/test_files/radlogo.png' }

        it 'validates' do
          expect(page).to have_content 'Logo, Avatar could not be saved due to invalid content types'
          expect(division.logo.attached?).to be false
          expect(division.avatar.attached?).to be false
        end
      end

      context 'one invalid' do
        let(:file1) { 'spec/test_files/radlogo.jpeg' }

        it 'validates' do
          expect(page).to have_content 'Logo could not be saved due to invalid content types'
          expect(division.logo.attached?).to be false
          expect(division.avatar.attached?).to be true
        end
      end
    end

    it 'displays error for owner field when blank', js: true do
      visit edit_division_path(division)
      fill_in 'owner_name', with: ''
      click_button 'Save'

      if ENV['CI']
        # TODO: fix this so it works locally
        expect(page).to have_content 'Owner must exist and Owner can\'t be blank'
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
