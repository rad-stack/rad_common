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
    let(:first_name_1) { 'Fredx' }
    let(:first_name_2) { 'Johnx' }

    let!(:record_1) do
      create :attorney, first_name: first_name_1, last_name: 'Flintstonex', phone_number: '(435) 123-1200'
    end

    let!(:record_2) do
      create :attorney,
             first_name: first_name_2,
             last_name: 'Smithx',
             phone_number: '(123) 555-9999',
             email: 'tester@example.com'
    end

    let!(:duplicate_1) do
      create :attorney, first_name: first_name_1, last_name: 'Flintstonex', phone_number: '(435) 123-1200'
    end

    let!(:duplicate_2) do
      create :attorney,
             first_name: first_name_2,
             last_name: 'Smithx',
             phone_number: '(123) 555-0000',
             email: 'tester@example.com'
    end

    let(:index_path) { "/rad_common/duplicates?model=#{model_name}" }

    before do
      record_1.process_duplicates
      record_2.process_duplicates
      duplicate_1.process_duplicates
      duplicate_2.process_duplicates

      record_1.update_column :updated_at, 5.days.ago
      record_2.update_column :updated_at, 4.days.ago
      duplicate_1.update_column :updated_at, 3.days.ago
      duplicate_2.update_column :updated_at, 2.days.ago
    end

    it 'allows user to mark record record as not duplicate' do
      visit index_path
      expect(page).to have_content('Fixing Attorneys (4)')
      expect(page).to have_content(first_name_2)
      expect(page).not_to have_content(first_name_1)

      click_link 'Switch to attorney'

      click_link 'Not a duplicate'
      expect(page).to have_content('Fixing Attorneys (2)')
    end

    it 'shows applicable columns' do
      visit index_path
      expect(page).to have_content('Fixing Attorneys (4)')
      expect(page).to have_content('Company Name')
    end

    it 'does not show non applicable columns' do
      visit index_path
      expect(page).to have_content('Fixing Attorneys (4)')
      expect(page).not_to have_content('Birth Date')
    end

    it 'allows user to skip duplicate record for later review' do
      visit index_path
      expect(page).to have_content('Fixing Attorneys (4)')
      expect(page).to have_content(first_name_2)
      expect(page).not_to have_content(first_name_1)

      click_link 'Skip for now, review later'
      expect(page).to have_content(first_name_1)
      expect(page).not_to have_content(first_name_2)
    end

    it 'allows user to merge duplicate contacts', js: true do
      visit index_path
      expect(page).to have_content('Fixing Attorneys (4)')
      expect(page).to have_content(first_name_2)
      expect(page).not_to have_content(first_name_1)

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('Fixing Attorneys (2)')
      expect(page).to have_content(first_name_1)
      expect(page).not_to have_content(first_name_2)
    end

    it 'shows fix duplicates', js: true do
      visit attorney_path(record_1)
      expect(page).to have_content('Fix Duplicates')

      click_link 'Fix Duplicates'
      expect(page).to have_content('Fixing Attorneys (4)')

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('Fixing Attorneys (2)')

      visit attorney_path(record_1)
      expect(page).not_to have_content('Fix Duplicates')

      visit "/rad_common/duplicates?model=#{model_name}&id=#{record_1.id}"
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end
  end
end
