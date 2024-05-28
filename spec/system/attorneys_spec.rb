require 'rails_helper'

RSpec.describe 'Attorneys' do
  let(:user) { create :admin }
  let(:attorney) { create :attorney }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_attorney_path
      expect(page).to have_content('New Attorney')
    end

    it "doesn't show the reset duplicates link", :js do
      visit new_attorney_path
      expect(page).to have_no_content('Reset Duplicates')
    end

    it 'triggers duplicates detection when entering', :js do
      visit new_attorney_path
      expect(page).to have_content('New Attorney')

      fill_in 'First Name', with: attorney.first_name
      fill_in 'Last Name', with: attorney.last_name
      fill_in 'attorney_phone_number', with: attorney.phone_number
      fill_in 'attorney_email', with: attorney.email

      expect(page).to have_content('This is not a duplicate')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_attorney_path(attorney)
      expect(page).to have_content('Editing Attorney')
    end

    it 'shows the reset duplicates link' do
      visit edit_attorney_path(attorney)
      expect(page).to have_content('Reset Duplicates')
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
    let(:index_path) { duplicates_path model: model_name }
    let(:record_1_path) { attorney_path(record_1) }
    let!(:record_1) { create :attorney, first_name: 'Fred123', last_name: 'Flintstone' }
    let!(:record_2) { create :attorney, first_name: 'John456', last_name: 'Smith' }
    let!(:duplicate_1) { create :attorney, first_name: 'Fred123', last_name: 'Flintstone' }
    let!(:duplicate_2) { create :attorney, first_name: 'John456', last_name: 'Smith' }

    before do
      allow_any_instance_of(DuplicatesProcessor).to receive(:duplicate_record_score).and_return 60
      allow(Attorney).to receive(:allow_merge_all?).and_return(true)
      allow_any_instance_of(Duplicate).to receive :maybe_notify!

      record_1.process_duplicates
      record_2.process_duplicates
      duplicate_1.process_duplicates
      duplicate_2.process_duplicates
    end

    it 'allows user to mark record record as not duplicate' do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content(record_2.first_name)
      expect(page).to have_no_content(record_1.first_name)

      click_link 'Switch to Current'

      click_link 'Not a duplicate'
      expect(page).to have_content('(2)')
    end

    it 'shows applicable columns' do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content('Company Name')
    end

    it 'does not show non applicable columns' do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_no_content('Birth Date')
    end

    it 'allows user to skip duplicate record for later review' do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content(record_2.first_name)
      expect(page).to have_no_content(record_1.first_name)

      click_link 'Skip for now, review later'
      expect(page).to have_content(record_1.first_name)
      expect(page).to have_no_content(record_2.first_name)
    end

    it 'allows user to merge duplicate contacts', :js do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content(record_2.first_name)
      expect(page).to have_no_content(record_1.first_name)

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('(2)')
      expect(page).to have_content(record_1.first_name)
    end

    it 'shows fix duplicates', :js do
      visit record_1_path
      expect(page).to have_content('Fix Duplicates')

      click_link 'Fix Duplicates'
      expect(page).to have_content('(4)')

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('(2)')

      visit record_1_path
      expect(page).to have_no_content('Fix Duplicates')

      visit duplicates_path(model: model_name, id: record_1.id)
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end
  end
end
