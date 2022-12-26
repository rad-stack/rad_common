require 'rails_helper'

RSpec.describe 'Divisions', type: :system do
  let(:user) { create :admin }
  let(:division) { create :division, owner: user }

  before { login_as user, scope: :user }

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

    context 'with default placeholder' do
      it 'shows placeholder on autocomplete field', js: true do
        visit new_division_path
        click_bootstrap_select(from: 'division_owner_id')
        expect(find("input[type='search']")['placeholder']).to eq('Start typing to search')
      end
    end

    context 'with custom placeholder' do
      it 'shows placeholder on autocomplete field', js: true do
        visit new_division_path
        click_bootstrap_select(from: 'division_category_id')
        expect(find("input[type='search']")['placeholder']).to eq('Search for a category')
      end
    end

    describe 'single attachment validation' do
      let(:file) { 'spec/fixtures/test.pdf' }

      before do
        visit new_division_path
        fill_in 'Name', with: 'Foo'
        fill_in 'Code', with: 'BAR'
        page.attach_file('Icon', file)
        click_on 'Save'
      end

      context 'when invalid due to content type' do
        it 'validates' do
          expect(page).to have_content 'Icon has an invalid content type of application/pdf, must be PNG'
          expect(division.icon.attached?).to be false
        end
      end

      context 'when invalid due to file size' do
        let(:file) { 'spec/fixtures/large_logo.png' }

        it 'validates' do
          expect(page).to have_content 'Icon must be less than 50 KB'
          expect(division.icon.attached?).to be false
        end
      end
    end
  end

  describe 'edit' do
    before { visit edit_division_path(division) }

    it 'renders the edit template' do
      expect(page).to have_content('Editing Division')
    end

    context 'with bootstrap select search field', js: true do
      let(:other_user) { create :user }

      before do
        other_user
        stub_const('SearchableAssociationInput::MAX_DROPDOWN_SIZE', 1)
        visit edit_division_path(division)
      end

      it 'allows searching' do
        click_bootstrap_select(from: 'division_owner_id')
        wait_for_ajax
        find('.bs-searchbox input').fill_in(with: other_user.first_name)
        expect(find('ul.inner li a span', text: other_user.to_s)).to be_present
      end

      it 'displays existing value' do
        expect(find("[data-id='division_owner_id']").text).to eq(division.owner.to_s)
        expect(find_field('division_owner_id', visible: false).value).to eq(division.owner.id.to_s)
      end
    end
  end

  describe 'index' do
    it 'displays the divisions' do
      division
      visit divisions_path(search: { division_status: 1 })
      expect(page).to have_content(division.to_s)
    end

    it 'handles date filter errors' do
      visit divisions_path

      fill_in 'search_created_at_start', with: '01/32/2020'
      click_button 'Apply Filters'
      expect(page).to have_content('Invalid date entered')
    end

    context 'with hidden filter' do
      it 'shows header' do
        visit divisions_path(search: { show_header: true })
        expect(page.body).to have_content 'Showing header'
        visit divisions_path
        expect(page.body).not_to have_content 'Showing header'
      end
    end

    context 'when saving search filters', js: true do
      let(:applied_params) { -> { Rack::Utils.parse_query URI.parse(current_url).query } }
      let(:last_filter) { SavedSearchFilter.last }

      it 'allows saving and applying search filters' do
        visit divisions_path
        bootstrap_select user.to_s, from: 'search_owner_id'
        click_on 'saved-search-filters-dropdown'
        page.evaluate_script 'window.prompt = () => { document.getElementById("search_saved_name").value = "Test" }'
        page.evaluate_script 'window.alert = (msg) => { return true; }'
        expect { click_on('save_and_apply_filters') }.to change(SavedSearchFilter, :count).by(1)

        expect(SavedSearchFilter.last.name).to eq('Test')
        expect(applied_params.call['search[owner_id]']).to eq(user.id.to_s)

        click_on 'Clear Filters'
        expect(applied_params.call['search[owner_id]']).to be_nil

        click_on 'saved-search-filters-dropdown'
        click_on "saved_filter_#{last_filter.id}"
        expect(applied_params.call['search[owner_id]']).to eq(user.id.to_s)
        click_on 'saved-search-filters-dropdown'
        expect(find_by_id("saved_filter_#{last_filter.id}")['class']).to include('active')
      end

      it 'allows deleting saved filters' do
        create(:saved_search_filter, user: user, search_class: 'DivisionSearch')
        visit divisions_path
        click_on 'saved-search-filters-dropdown'
        page.accept_confirm { click_on "delete_saved_filter_#{last_filter.id}" }
        wait_for_ajax
        expect(SavedSearchFilter.count).to eq(0)
      end
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

    it 'shows translated version of field name' do
      expect(page).to have_content 'Additional data'
      expect(page).not_to have_content 'Additional info'
    end

    it 'shows translated enum value' do
      expect(page).to have_content 'Active'
      expect(page).not_to have_content 'status_active'
    end

    context 'with attachments' do
      let(:prompt) { 'Are you sure? Attachment cannot be recovered.' }
      let(:file) { File.open Rails.root.join('app/assets/images/app_logo.png') }

      before do
        division.logo.attach(io: file, filename: 'logo.png')
        visit division_path(division)
      end

      it 'allows attachment to be deleted', js: true do
        expect(ActiveStorage::Attachment.count).to eq 1

        page.accept_alert prompt do
          first('dd .fa-times').click
        end

        division.reload
        expect(page).to have_content 'Attachment successfully deleted'
        expect(ActiveStorage::Attachment.count).to eq 0
        expect(division.logo.attached?).to be false
      end
    end
  end
end
