require 'rails_helper'

RSpec.describe 'Divisions' do
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
      it 'shows placeholder on autocomplete field', :js do
        visit new_division_path
        click_tom_select(from: 'division_owner_id')

        within '#division_owner_id-ts-control' do
          expect(find('input', visible: :all)[:placeholder]).to eq('Start typing to search')
        end
      end
    end

    describe 'single attachment validation' do
      let(:file) { 'spec/fixtures/test.pdf' }

      before do
        visit new_division_path
        fill_in 'Name', with: 'Foo'
        fill_in 'Code', with: 'BAR'
        page.attach_file('Icon', file)
        click_button 'Save'
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

    it 'shows tooltips on radio buttons' do
      visit new_division_path
      expect(page.body).to include('Division is pending approval')
    end
  end

  describe 'edit' do
    before { visit edit_division_path(division) }

    it 'renders the edit template' do
      expect(page).to have_content('Editing Division')
    end

    context 'with tom select search field', :js do
      let(:other_user) { create :user }

      before do
        other_user
        stub_const('SearchableDropdownHelper::MAX_DROPDOWN_SIZE', 1)
        visit edit_division_path(division)
      end

      it 'allows searching' do
        click_tom_select(from: 'division_owner_id', skip_dropdown_check: true)
        first('.dropdown-input').fill_in(with: other_user.first_name)
        expect(find('[data-selectable]', text: other_user.to_s)).to be_present
      end

      it 'displays existing value' do
        within '#division_owner_id-ts-control' do
          expect(find('[data-ts-item]').text).to eq(division.owner.to_s)
        end
        expect(find_field('division_owner_id', visible: false).value).to eq(division.owner.id.to_s)
      end

      it 'displays the translated label' do
        expect(page).to have_content 'API Key'
      end

      it 'displays the titleized label' do
        expect(page).to have_content 'Hourly Rate'
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

      first('#search_created_at_start').fill_in(with: '01/32/2020')
      first('button', text: 'Apply Filters').click
      expect(page).to have_content('Invalid date entered')
    end

    context 'with hidden filter' do
      it 'shows header' do
        visit divisions_path(search: { show_header: true })
        expect(page.body).to have_content 'Showing header'
        visit divisions_path
        expect(page.body).to have_no_content 'Showing header'
      end
    end

    context 'when saving search filters', :js do
      let(:applied_params) { -> { Rack::Utils.parse_query URI.parse(current_url).query } }
      let(:last_filter) { SavedSearchFilter.last }
      let(:filters) { { name_like_match_type: 'Division' } }

      it 'allows saving applied search filters', :js do
        visit divisions_path
        first('#search_name_like').fill_in(with: 'Division Test')
        tom_select user.to_s, from: 'search_owner_id'
        first('button', text: 'Apply Filters').click
        expect(SavedSearchFilter.count).to eq(0)
        click_button 'saved-search-filters-dropdown'
        click_button 'save_and_apply_filters'
        expect(page).to have_css('#saved-search-filters-modal.show', visible: :visible)
        within '#saved-search-filters-modal' do
          fill_in 'saved_search_filter_name', with: 'Division Test'
          click_button 'save_filter'
        end
        sleep 0.5
        find_by_id('close-saved-search-filters-modal').click
        expect(page).to have_no_css('#saved-search-filters-modal.show', visible: :visible)

        click_button 'saved-search-filters-dropdown'
        expect(page).to have_css("#saved_filter_item_#{last_filter.id}", text: 'Division Test')
        expect(SavedSearchFilter.count).to eq(1)

        expect(applied_params.call['search[name_like]']).to eq(last_filter.name)
        expect(applied_params.call['search[owner_id]']).to eq(user.id.to_s)

        click_link 'Clear Filters'
        expect(applied_params.call['search[name_like]']).to be_nil
        expect(applied_params.call['search[owner_id]']).to be_nil

        click_button 'saved-search-filters-dropdown'
        click_link "saved_filter_#{last_filter.id}"
        expect(applied_params.call['search[name_like]']).to eq(last_filter.name)
        expect(applied_params.call['search[owner_id]']).to eq(user.id.to_s)
        click_button 'saved-search-filters-dropdown'
        expect(find_by_id("saved_filter_#{last_filter.id}")['class']).to include('text-success')
      end

      it 'allows deleting saved filters' do
        create :saved_search_filter, user: user, search_class: 'divisions_search', search_filters: filters
        visit divisions_path
        click_button 'saved-search-filters-dropdown'
        expect(SavedSearchFilter.count).to eq(1)
        page.accept_confirm { click_link "delete_saved_filter_#{last_filter.id}" }
        wait_for_ajax
        expect(SavedSearchFilter.count).to eq(0)
      end
    end

    context 'when using quick view offcanvas', :js do
      it 'displays division details in offcanvas' do
        division
        visit divisions_path

        expect(page).to have_content(division.name)

        click_link 'Quick View', match: :first

        expect(page).to have_css('.offcanvas.show', visible: :visible)
        expect(page).to have_css('.offcanvas-title', text: "Quick View: #{division.name}")

        within '.offcanvas-body' do
          expect(page).to have_content(division.name)
          expect(page).to have_content(division.code)
          expect(page).to have_content(division.owner.to_s)
          expect(page).to have_link('View Full Details', href: division_path(division))
        end

        find('.offcanvas .btn-close').click
        expect(page).to have_no_css('.offcanvas.show', visible: :visible)
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
      expect(page).to have_content 'Additional Data'
      expect(page).to have_no_content 'Additional Info'
    end

    it 'shows translated enum value' do
      expect(page).to have_content 'Active'
      expect(page).to have_no_content 'status_active'
    end

    context 'with attachments' do
      let(:prompt) { 'Are you sure? Attachment cannot be recovered.' }
      let(:file) { Rails.root.join('app/assets/images/app_logo.png').open }

      before do
        division.logo.attach(io: file, filename: 'logo.png')
        visit division_path(division)
      end

      it 'allows attachment to be deleted', :js do
        page.accept_alert prompt do
          first('dd .fa-times').click
        end

        expect(page).to have_css("#toast-nav[data-toast-success-message-value='Attachment successfully deleted']")
      end
    end
  end
end
