import { Controller } from '@hotwired/stimulus';
import { Turbo } from '@hotwired/turbo-rails';

export default class extends Controller {
  static targets = ['modelSelect', 'hiddenColumnsConfig', 'selectedColumnsList', 'selectedColumnRow', 'calculatedColumnFrame'];
  static values = { filterTypesMap: Object };

  modelChanged(event) {
    const selectedModel = event.target.value;
    if (selectedModel) {
      const frame = document.getElementById('report_model_context');
      frame.src = `/custom_reports/model_context?report_model=${encodeURIComponent(selectedModel)}`;
    }
  }

  filterColumnChanged(event) {
    const select = event.target;
    const selectedOption = select.options[select.selectedIndex];
    const columnType = selectedOption.dataset.columnType;
    const isForeignKey = selectedOption.dataset.isForeignKey === 'true';
    const isEnum = selectedOption.dataset.isEnum === 'true';
    const card = select.closest('.filter-card');

    const labelInput = card.querySelector('input[name="custom_report[filters][][label]"]');
    if (labelInput && select.value) {
      const columnName = select.value.split('.').pop();
      labelInput.value = this.generateLabel(columnName);
    }

    const typeSelect = card.querySelector('select[name="custom_report[filters][][type]"]');
    if (typeSelect && columnType) {
      let filterTypes = this.filterTypesMapValue[columnType] || this.filterTypesMapValue['string'];

      if (isEnum) {
        filterTypes = [['Enum', 'RadSearch::EnumFilter']];
      } else if (!isForeignKey) {
        filterTypes = filterTypes.filter(filter => filter[1] !== 'RadSearch::SearchFilter');
      }

      this.resetTomSelect(typeSelect, filterTypes);
    }
  }

  resetTomSelect(selectElement, filterTypes) {
    const tomselect = selectElement.tomselect;
    tomselect.clear();
    tomselect.clearOptions();
    filterTypes.forEach((filter) => {
      tomselect.addOption({ value: filter[1], text: filter[0] });
    });
    tomselect.refreshOptions(false);
    tomselect.setValue(filterTypes[0][1]);
  }

  updateColumnLabel(event) {
    const input = event.target;
    const row = input.closest('tr');
    row.dataset.columnLabel = input.value;
  }

  updateColumnSortable(event) {
    const checkbox = event.target;
    const row = checkbox.closest('tr');
    row.dataset.columnSortable = checkbox.checked;
  }

  submitForm(_event) {
    this.hiddenColumnsConfigTarget.innerHTML = '';

    this.selectedColumnRowTargets.forEach((row, index) => {
      const colName = row.dataset.columnName;
      const table = row.dataset.columnTable;
      const association = row.dataset.columnAssociation;
      const type = row.dataset.columnType;
      const isCalculated = row.dataset.isCalculated === 'true' || type === 'calculated' || table === 'calculated';

      // Get custom label from the input field, or use the data attribute, or generate it
      const labelInput = row.querySelector('input[type="text"]');
      const customLabel = labelInput ? labelInput.value : (row.dataset.columnLabel || this.generateLabel(colName));

      const formula = this.buildFormulaForRow(row, isCalculated);

      const sortableCheckbox = row.querySelector('input[type="checkbox"]');
      const isSortable = sortableCheckbox ? sortableCheckbox.checked : false;

      this.createHiddenInput(`custom_report[columns][${index}][name]`, colName);
      this.createHiddenInput(
        `custom_report[columns][${index}][label]`,
        customLabel
      );

      // For calculated columns, we don't set a select clause since they don't map to DB columns
      if (isCalculated) {
        this.createHiddenInput(
          `custom_report[columns][${index}][is_calculated]`,
          '1'
        );
      } else if (type !== 'rich_text') {
        const selectPrefix = association && association !== '' ? association : table;
        this.createHiddenInput(
          `custom_report[columns][${index}][select]`,
          `${selectPrefix}.${colName}`
        );
      }

      if (formula) {
        this.createHiddenInput(
          `custom_report[columns][${index}][formula]`,
          formula
        );
      }

      this.createHiddenInput(
        `custom_report[columns][${index}][sortable]`,
        isSortable ? '1' : '0'
      );
    });
  }

  buildFormulaForRow(row, isCalculated) {
    const transforms = row.dataset.columnFormula || '';

    if (isCalculated) {
      const calculation = row.dataset.columnCalculation || '';
      const calcObj = calculation ? this.parseJson(calculation) : null;
      const transformsArr = transforms ? this.parseJson(transforms) : [];

      if (calcObj) {
        const combined = [calcObj, ...(Array.isArray(transformsArr) ? transformsArr : [])];
        return JSON.stringify(combined);
      }
    }

    return transforms;
  }

  parseJson(str) {
    if (!str) return null;
    try {
      return JSON.parse(str);
    } catch {
      return null;
    }
  }


  createHiddenInput(name, value) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    this.hiddenColumnsConfigTarget.appendChild(input);
  }

  loadCalculatedColumnForm(event) {
    const url = event.currentTarget.dataset.calculatedColumnUrl;
    if (!url) {
      return;
    }

    const refreshedUrl = new URL(url, window.location.origin);
    refreshedUrl.searchParams.set('_', Date.now().toString());

    const frameId = this.hasCalculatedColumnFrameTarget
      ? this.calculatedColumnFrameTarget.id
      : 'calculated-column-form-frame';

    Turbo.visit(refreshedUrl.toString(), { frame: frameId });
  }

  editCalculatedColumn(event) {
    const url = event.currentTarget.dataset.calculatedColumnUrl;
    if (!url) {
      return;
    }

    const refreshedUrl = new URL(url, window.location.origin);
    refreshedUrl.searchParams.set('_', Date.now().toString());

    const row = event.currentTarget.closest('tr');
    if (row) {
      refreshedUrl.searchParams.set('row_id', row.id);
    }

    const frameId = this.hasCalculatedColumnFrameTarget
      ? this.calculatedColumnFrameTarget.id
      : 'calculated-column-form-frame';

    Turbo.visit(refreshedUrl.toString(), { frame: frameId });
  }

  loadCustomReportFilterForm(event) {
    const url = event.currentTarget.dataset.customReportFilterUrl;
    if (!url) {
      return;
    }

    const refreshedUrl = new URL(url, window.location.origin);
    refreshedUrl.searchParams.set('_', Date.now().toString());

    Turbo.visit(refreshedUrl.toString(), { frame: 'custom-report-filter-form-frame' });
  }

  removeColumn(event) {
    event.currentTarget.closest('tr')?.remove();
  }

  removeFilter(event) {
    event.currentTarget.closest('.filter-row')?.remove();
  }

  generateLabel(colName) {
    return colName.replace(/_/g, ' ').replace(/\b\w/g, (letter) => letter.toUpperCase());
  }

  async selectAllColumns(event) {
    event.preventDefault();
    const selectAllButton = event.currentTarget;

    const availableColumnsCard = document.querySelector('.col-md-6:first-child .card');
    const selectedColumnsCard = document.querySelector('.col-md-6:last-child .card');

    const originalHTML = selectAllButton.innerHTML;
    selectAllButton.disabled = true;
    selectAllButton.innerHTML = '<i class="fa fa-spinner fa-spin me-1"></i>Adding...';

    this.addLoadingOverlay(availableColumnsCard);
    this.addLoadingOverlay(selectedColumnsCard);

    let addButton = this.getFirstAvailableColumnButton();
    while (addButton) {
      addButton.click();
      await new Promise(resolve => setTimeout(resolve, 50));
      addButton = this.getFirstAvailableColumnButton();
    }

    this.removeLoadingOverlay(availableColumnsCard);
    this.removeLoadingOverlay(selectedColumnsCard);

    selectAllButton.innerHTML = originalHTML;
    selectAllButton.disabled = false;
  }

  getFirstAvailableColumnButton() {
    const activeTabPane = document.querySelector('.tab-pane.show.active');
    if (!activeTabPane) {
      return null;
    }
    return activeTabPane.querySelector('a[data-testid="add-column-button"]');
  }

  addLoadingOverlay(element) {
    if (!element) return;

    const overlay = document.createElement('div');
    overlay.className = 'select-all-loading-overlay position-absolute top-0 start-0 end-0 bottom-0 bg-white bg-opacity-75 d-flex align-items-center justify-content-center';
    overlay.style.zIndex = '10';
    overlay.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>';
    element.classList.add('position-relative');
    element.appendChild(overlay);
  }

  removeLoadingOverlay(element) {
    if (!element) return;

    const overlay = element.querySelector('.select-all-loading-overlay');
    if (overlay) {
      overlay.remove();
    }
  }
}
