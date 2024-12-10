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
    let(:index_path) { "/rad_common/duplicates?model=#{model_name}" }
    let(:record_1_path) { attorney_path(record_1) }
    let!(:record_1) { create :attorney, first_name: 'Fred123', last_name: 'Flintstone' }
    let!(:record_2) { create :attorney, first_name: 'John456', last_name: 'Smith' }
    let!(:duplicate_1) { create :attorney, first_name: 'Fred123', last_name: 'Flintstone' }
    let!(:duplicate_2) { create :attorney, first_name: 'John456', last_name: 'Smith' }

    before do
      allow_any_instance_of(DuplicateFixable).to receive(:duplicate_record_score).and_return 60
      allow(Attorney).to receive(:allow_merge_all?).and_return(true)

      record_1.process_duplicates
      record_2.process_duplicates
      duplicate_1.process_duplicates
      duplicate_2.process_duplicates
    end

    it 'allows user to mark record record as not duplicate' do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content(record_2.first_name)
      expect(page).not_to have_content(record_1.first_name)

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
      expect(page).not_to have_content('Birth Date')
    end

    it 'allows user to skip duplicate record for later review' do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content(record_2.first_name)
      expect(page).not_to have_content(record_1.first_name)

      click_link 'Skip for now, review later'
      expect(page).to have_content(record_1.first_name)
      expect(page).not_to have_content(record_2.first_name)
    end

    it 'allows user to merge duplicate contacts', js: true do
      visit index_path
      expect(page).to have_content('(4)')
      expect(page).to have_content(record_2.first_name)
      expect(page).not_to have_content(record_1.first_name)

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('(2)')
      expect(page).to have_content(record_1.first_name)
    end

    it 'shows fix duplicates', js: true do
      visit record_1_path
      expect(page).to have_content('Fix Duplicates')

      click_link 'Fix Duplicates'
      expect(page).to have_content('(4)')

      page.accept_confirm { click_button 'Merge All' }
      expect(page).to have_content('(2)')

      visit record_1_path
      expect(page).not_to have_content('Fix Duplicates')

      visit "/rad_common/duplicates?model=#{model_name}&id=#{record_1.id}"
      expect(page).to have_content('Congratulations, there are no more duplicates found!')
    end
  end
end
