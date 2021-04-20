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

  describe 'duplicates' do
    let(:user) { create :admin }
    let(:model_name) { 'Attorney' }
    let(:record) { attorney }
    let(:index_path) { "/rad_common/duplicates?model=#{model_name}" }

    before do
      record.first_name = 'Fredx'
      record.last_name = 'Flintstonex'
      record.phone_number = '(435) 123-1200'
      record.save!

      duplicate_record = create :attorney
      duplicate_record.first_name = 'Fredx'
      duplicate_record.last_name = 'Flintstonex'
      duplicate_record.phone_number = '(435) 123-1200'
      duplicate_record.save!

      process_duplicates
    end

    it 'allows user to mark record record as not duplicate', js: true do
      visit index_path
      expect(page).to have_content('Fixing Attorneys (2)')

      click_link 'Switch to attorney'

      click_link 'Not a duplicate'
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end

    it 'does not show the birth date column' do
      visit index_path
      expect(page).not_to have_content('Birth Date')
    end

    it 'allows user to skip duplicate record for later review' do
      duplicate_record_2 = create :attorney
      duplicate_record_2.first_name = 'Johnx'
      duplicate_record_2.last_name = 'Smithx'
      duplicate_record_2.phone_number = '(123) 555-9999'
      duplicate_record_2.email = 'tester@example.com'
      duplicate_record_2.save!(validate: false)
      duplicate_record_3 = create :attorney
      duplicate_record_3.first_name = 'Johnx'
      duplicate_record_3.last_name = 'Smithx'
      duplicate_record_3.phone_number = '(123) 555-0000'
      duplicate_record_3.email = 'tester@example.com'
      duplicate_record_3.save!(validate: false)
      process_duplicates

      visit index_path
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
      visit index_path
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

      visit "/rad_common/duplicates?model=#{model_name}&id=#{record.id}"
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end

    def process_duplicates
      Attorney.all.each(&:process_duplicates)
    end
  end
end
