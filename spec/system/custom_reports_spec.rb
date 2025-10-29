require 'rails_helper'

RSpec.describe 'CustomReports' do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  around(:each, :flakey_js) do |example|
    Capybara.using_session(SecureRandom.hex(4)) do
      example.run
    end
  end

  describe 'new', :js do
    it 'renders view based on base model selection' do
      visit new_custom_report_path
      expect(page).to have_content('New Custom Report')
      expect(page).to have_no_content('Related Tables (Joins)')
      expect(page).to have_no_content('Report Columns')
      expect(page).to have_no_content('Filters')
      tom_select 'Division', from: 'custom_report_report_model'
      expect(page).to have_content('Related Tables (Joins)')
      expect(page).to have_content('Report Columns')
      expect(page).to have_content('Filters')
    end

    context 'when selecting and deselecting columns' do
      it 'updates moves selected columns between available and selected lists' do
        visit new_custom_report_path
        tom_select 'Division', from: 'custom_report_report_model'

        within '#report_joins_section' do
          find('.dropdown-toggle').click
          click_on 'Owner'
        end

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end

          expect(page).to have_no_css('#available-column-divisions-name')
        end

        find('[data-bs-target="#columns-table-owner"]').click

        within '#columns-table-owner' do
          within '#available-column-owner-email' do
            find('[data-testid="add-column-button"]').click
          end

          expect(page).to have_no_css('#available-column-owner-email')
        end

        within '#selected-columns-list' do
          expect(find_by_id('selected-column-divisions-name')).to be_present
          expect(find_by_id('selected-column-owner-email')).to be_present
        end

        within '#selected-columns-list' do
          within '#selected-column-divisions-name' do
            find('[data-testid="remove-column-button"]').click
          end

          within '#selected-column-owner-email' do
            find('[data-testid="remove-column-button"]').click
          end
        end

        within '#selected-columns-list' do
          expect(page).to have_no_css('#selected-column-divisions-name')
          expect(page).to have_no_css('#selected-column-owner-email')
        end

        find('[data-bs-target="#columns-table-divisions"]').click

        within '#columns-table-divisions' do
          expect(page).to have_css('#available-column-divisions-name')
        end

        find('[data-bs-target="#columns-table-owner"]').click

        within '#columns-table-owner' do
          expect(page).to have_css('#available-column-owner-email')
        end
      end
    end

    context 'when adding calculated columns', :flakey_js, :ignore_browser_errors do
      before { create :division, name: 'east', code: '123' }

      it 'shows calculated column modal and adds calculated column' do
        visit new_custom_report_path
        tom_select 'Division', from: 'custom_report_report_model'

        fill_in 'custom_report_name', with: 'Division Report'

        find('[data-bs-target="#calculated-column-modal"]').click

        within '#calculated-column-modal' do
          click_on 'Add Column'
          expect(page).to have_content('Label can\'t be blank')
          select 'Concatenate', from: 'calculated_column_formula_type'
          tom_select 'Division.code', from: 'calculated-column-concat_columns-columns'
          wait_for_ajax
          tom_select 'Division.name', from: 'calculated-column-concat_columns-columns'
          fill_in 'calculated_column_label', with: 'Name and Code'
          click_on 'Add Column'
        end

        within '#selected-columns-list' do
          expect(page).to have_content('calculated.name_and_code')
        end

        click_on 'Save'

        expect(page).to have_content('Division Report')
        expect(page).to have_content('Name and Code')
        expect(page).to have_content('123 east')
      end
    end

    context 'when adding formulas to columns' do
      before { create :division, name: 'east' }

      it 'shows formula editor and saves formula' do
        visit new_custom_report_path
        tom_select 'Division', from: 'custom_report_report_model'

        fill_in 'custom_report_name', with: 'Division Report'

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end
        end

        within '#selected-column-divisions-name' do
          find('[data-action="click->formula-editor#open"]').click
        end

        within '[data-formula-editor-target="modal"]' do
          tom_select 'Uppercase', from: 'transform-select'
          find('[data-action="click->formula-editor#addTransform"]').click
          wait_for_ajax
          find('[data-action="click->formula-editor#saveFormula"]').click
        end

        click_on 'Save'

        expect(page).to have_content('EAST')
      end
    end

    context 'when adding and removing joins' do
      it 'updates joins section and available tables' do
        visit new_custom_report_path
        tom_select 'Division', from: 'custom_report_report_model'

        within '[data-testid="available-tables-list"]' do
          expect(page).to have_content('Division')
          expect(page).to have_no_content('Owner')
        end

        within '[data-testid="report-joins-list"]' do
          expect(page).to have_no_content('Owner')
        end

        within '#report_joins_section' do
          find('.dropdown-toggle').click
          click_on 'Owner'
        end

        within '[data-testid="available-tables-list"]' do
          expect(page).to have_content('Division')
          expect(page).to have_content('Owner')
        end

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end
        end

        within '#selected-columns-list' do
          expect(find_by_id('selected-column-divisions-name')).to be_present
        end

        find('[data-bs-target="#columns-table-owner"]').click

        within '#columns-table-owner' do
          within '#available-column-owner-email' do
            find('[data-testid="add-column-button"]').click
          end
        end

        within '#selected-columns-list' do
          expect(find_by_id('selected-column-owner-email')).to be_present
        end

        within '[data-testid="report-joins-list"]' do
          expect(page).to have_content('Owner')
        end

        within '#report_joins_section [data-join-name="owner"]' do
          find('[data-testid="remove-join-button"]').click
        end

        within '[data-testid="available-tables-list"]' do
          expect(page).to have_no_content('Owner')
        end

        within '[data-testid="report-joins-list"]' do
          expect(page).to have_no_content('Owner')
        end

        within '#selected-columns-list' do
          expect(page).to have_no_css('#selected-column-owner-email')
        end
      end
    end

    context 'when adding filters' do
      it 'adds a new filter card to the filters section' do
        visit new_custom_report_path
        tom_select 'Division', from: 'custom_report_report_model'
        fill_in 'custom_report_name', with: 'Division Report'

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end
        end

        expect(page).to have_no_css('.filter-row')

        click_on 'Add Filter'

        expect(page).to have_css('#custom-report-filter-modal', visible: :visible)

        within '#custom-report-filter-modal' do
          tom_select 'Name - string', from: 'custom_report_filter_column'
          fill_in 'custom_report_filter_label', with: 'Division Name'
          click_on 'Add Filter'
        end

        expect(page).to have_css('[data-report-builder-target="filterRow"]', count: 1)
      end
    end
  end

  describe 'edit', :js do
    let(:custom_report) do
      CustomReport.create!(
        name: 'Division Report',
        report_model: 'Division',
        configuration: {
          columns: [{ name: 'id', select: 'divisions.id', label: 'ID', sortable: true }],
          joins: [],
          filters: []
        }
      )
    end

    context 'when selecting and deselecting columns' do
      it 'updates moves selected columns between available and selected lists' do
        visit edit_custom_report_path(custom_report)

        within '#report_joins_section' do
          find('.dropdown-toggle').click
          click_on 'Owner'
        end

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end

          expect(page).to have_no_css('#available-column-divisions-name')
        end

        find('[data-bs-target="#columns-table-owner"]').click

        within '#columns-table-owner' do
          within '#available-column-owner-email' do
            find('[data-testid="add-column-button"]').click
          end

          expect(page).to have_no_css('#available-column-owner-email')
        end

        within '#selected-columns-list' do
          expect(find_by_id('selected-column-divisions-name')).to be_present
          expect(find_by_id('selected-column-owner-email')).to be_present
        end

        within '#selected-columns-list' do
          within '#selected-column-divisions-name' do
            find('[data-testid="remove-column-button"]').click
          end

          within '#selected-column-owner-email' do
            find('[data-testid="remove-column-button"]').click
          end
        end

        within '#selected-columns-list' do
          expect(page).to have_no_css('#selected-column-divisions-name')
          expect(page).to have_no_css('#selected-column-owner-email')
        end

        find('[data-bs-target="#columns-table-divisions"]').click

        within '#columns-table-divisions' do
          expect(page).to have_css('#available-column-divisions-name')
        end

        find('[data-bs-target="#columns-table-owner"]').click

        within '#columns-table-owner' do
          expect(page).to have_css('#available-column-owner-email')
        end
      end
    end

    context 'when adding formulas to columns' do
      before { create :division, name: 'east' }

      it 'shows formula editor and saves formula', :flakey_js do
        visit edit_custom_report_path(custom_report)

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end
        end

        within '#selected-column-divisions-name' do
          find('[data-action="click->formula-editor#open"]').click
        end

        within '[data-formula-editor-target="modal"]' do
          tom_select 'Uppercase', from: 'transform-select'
          find('[data-action="click->formula-editor#addTransform"]').click
          wait_for_ajax
          find('[data-action="click->formula-editor#saveFormula"]').click
        end

        click_on 'Save'

        expect(page).to have_content('EAST')
      end
    end

    context 'when adding calculated columns', :flakey_js, :ignore_browser_errors do
      before { create :division, name: 'east', code: '123' }

      it 'shows calculated column modal and adds calculated column' do
        visit edit_custom_report_path(custom_report)

        find('[data-bs-target="#calculated-column-modal"]').click

        within '#calculated-column-modal' do
          click_on 'Add Column'
          expect(page).to have_content('Label can\'t be blank')
          select 'Concatenate', from: 'calculated_column_formula_type'
          tom_select 'Division.code', from: 'calculated-column-concat_columns-columns'
          wait_for_ajax
          tom_select 'Division.name', from: 'calculated-column-concat_columns-columns'
          fill_in 'calculated_column_label', with: 'Name and Code'
          click_on 'Add Column'
        end

        within '#selected-columns-list' do
          expect(page).to have_content('calculated.name_and_code')
        end

        click_on 'Save'

        expect(page).to have_content('Division Report')
        expect(page).to have_content('Name and Code')
        expect(page).to have_content('123 east')
      end
    end

    context 'when adding and removing joins' do
      it 'updates joins section and available tables', :flakey_js do
        visit edit_custom_report_path(custom_report)

        within '[data-testid="available-tables-list"]' do
          expect(page).to have_content('Division')
          expect(page).to have_no_content('Owner')
        end

        within '[data-testid="report-joins-list"]' do
          expect(page).to have_no_content('Owner')
        end

        within '#report_joins_section' do
          find('.dropdown-toggle').click
          click_on 'Owner'
        end

        within '[data-testid="available-tables-list"]' do
          expect(page).to have_content('Division')
          expect(page).to have_content('Owner')
        end

        within '#columns-table-divisions' do
          within '#available-column-divisions-name' do
            find('[data-testid="add-column-button"]').click
          end
        end

        within '#selected-columns-list' do
          expect(find_by_id('selected-column-divisions-name')).to be_present
        end

        find('[data-bs-target="#columns-table-owner"]').click

        within '#columns-table-owner' do
          within '#available-column-owner-email' do
            find('[data-testid="add-column-button"]').click
          end
        end

        within '#selected-columns-list' do
          expect(find_by_id('selected-column-owner-email')).to be_present
        end

        within '[data-testid="report-joins-list"]' do
          expect(page).to have_content('Owner')
        end

        within '#report_joins_section [data-join-name="owner"]' do
          find('[data-testid="remove-join-button"]').click
        end

        within '[data-testid="available-tables-list"]' do
          expect(page).to have_no_content('Owner')
        end

        within '[data-testid="report-joins-list"]' do
          expect(page).to have_no_content('Owner')
        end

        within '#selected-columns-list' do
          expect(page).to have_no_css('#selected-column-owner-email')
        end
      end
    end
  end

  describe 'show', :js do
    let(:custom_report) do
      CustomReport.create!(
        name: 'Division Report with Owner',
        report_model: 'Division',
        configuration: {
          columns: [
            { name: 'name', select: 'divisions.name', label: 'Division Name', sortable: true,
              formula: [{ type: 'UPPER' }] },
            { name: 'email', select: 'owner.email', label: 'Owner Email', sortable: true }
          ],
          joins: ['owner'],
          filters: [
            { column: 'divisions.name', type: 'RadSearch::LikeFilter', label: 'Division Name' },
            { column: 'owner.email', type: 'RadSearch::LikeFilter', label: 'Owner Email' }
          ]
        }
      )
    end
    let(:owner) { create :user }

    before do
      create :division, name: 'Engineering', owner: owner
    end

    it 'renders report with joins, columns, transforms, and filters applied' do
      visit custom_report_path(custom_report)

      expect(page).to have_content('Division Report with Owner')
      expect(page).to have_content('ENGINEERING')
      expect(page).to have_content(owner.email)
      expect(page).to have_content('Division Name')
      expect(page).to have_content('Owner Email')
    end
  end

  describe 'index' do
    let!(:custom_report) { create :custom_report }

    it 'lists existing custom reports' do
      visit custom_reports_path
      expect(page).to have_content(custom_report.name)
    end
  end
end
