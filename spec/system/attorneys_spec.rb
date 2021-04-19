require 'rails_helper'

RSpec.describe 'Attorneys', type: :system do
  let(:user) { create :admin }
  let(:attorney) { create :attorney }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_attorney_path
      expect(page).to have_content('New Attorney')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_attorney_path(attorney)
      expect(page).to have_content('Editing Attorney')
    end
  end

  describe 'index' do
    it 'displays the attorneys' do
      attorney
      visit attorneys_path
      expect(page).to have_content(attorney.to_s)
    end
  end

  describe 'show' do
    it 'shows the attorney' do
      visit attorney_path(attorney)
      expect(page).to have_content(attorney.to_s)
    end
  end

  describe 'duplicate attorneys' do
    let(:user) { create :admin }

    before do
      attorney.first_name = 'Fredx'
      attorney.last_name = 'Flintstonex'
      attorney.phone_number = '(435) 123-1200'
      attorney.save!

      duplicate_attorney = create(:attorney)
      duplicate_attorney.first_name = 'Fredx'
      duplicate_attorney.last_name = 'Flintstonex'
      duplicate_attorney.phone_number = '(435) 123-1200'
      duplicate_attorney.save!

      process_duplicate_attorneys
    end

    it 'allows user to mark attorney record as not duplicate', js: true do
      visit show_current_duplicates_attorneys_path
      expect(page).to have_content('Fixing Attorneys (2)')

      click_link 'Switch to attorney'

      click_link 'Not a duplicate'
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end

    it 'does not show the birth date column' do
      visit show_current_duplicates_attorneys_path
      expect(page).not_to have_content('Birth Date')
    end

    it 'allows user to skip duplicate attorney for later review' do
      duplicate_attorney_2 = create(:attorney)
      duplicate_attorney_2.first_name = 'Johnx'
      duplicate_attorney_2.last_name = 'Smithx'
      duplicate_attorney_2.phone_number = '(123) 555-9999'
      duplicate_attorney_2.email = 'tester@example.com'
      duplicate_attorney_2.save!(validate: false)
      duplicate_attorney_3 = create(:attorney)
      duplicate_attorney_3.first_name = 'Johnx'
      duplicate_attorney_3.last_name = 'Smithx'
      duplicate_attorney_3.phone_number = '(123) 555-0000'
      duplicate_attorney_3.email = 'tester@example.com'
      duplicate_attorney_3.save!(validate: false)
      process_duplicate_attorneys

      visit show_current_duplicates_attorneys_path
      expect(page).to have_content('Fixing Attorneys (4)')
      expect(page).to have_content('Johnx')
      expect(page).to have_content('Smithx')
      expect(page).not_to have_content('Fredx')
      expect(page).not_to have_content('Flintstonex')

      click_link 'Skip for now, review later'
      expect(page).to have_content('Fredx')
      expect(page).to have_content('Flintstonex')
      expect(page).not_to have_content('Johnx')
      expect(page).not_to have_content('Smithx')
    end

    it 'allows user to merge duplicate contacts', js: true do
      visit show_current_duplicates_attorneys_path
      expect(page).to have_content('Fixing Attorneys (2)')

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end

    it 'shows fix duplicates', js: true do
      visit attorney_path(attorney)
      expect(page).to have_content('Fix Duplicates')

      click_link 'Fix Duplicates'
      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('Congratulations, there are no more duplicates found!')

      visit attorney_path(attorney)
      expect(page).not_to have_content('Fix Duplicates')

      visit show_current_duplicates_attorneys_path(attorney_id: attorney.id)
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end

    def process_duplicate_attorneys
      Attorney.all.each(&:process_duplicates)
    end
  end
end
