import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'modelSelect',
    'hiddenColumnsConfig',
    'selectedColumnsList'
  ];

  static values = {
    filterTypesMap: Object
  };

  connect() {
    this.draggedElement = null;
  }

  modelChanged(event) {
    const selectedModel = event.target.value;
    if (selectedModel) {
      const url = new URL(window.location.href);
      url.searchParams.set('report_model', selectedModel);
      window.location.href = url.toString();
    }
  }

  addColumnToSelected(event) {
    const row = event.currentTarget;
    const columnName = row.dataset.columnName;
    const columnTable = row.dataset.columnTable;
    const columnType = row.dataset.columnType;
    const columnAssociation = row.dataset.columnAssociation;
    const columnTableLabel = row.dataset.columnTableLabel;
    const columnAssociationLabel = row.dataset.columnAssociationLabel;
    const humanName = this.generateLabel(columnName);

    // Build the full column path (e.g., "Owner.name" or "Users.name")
    let columnPath;
    if (columnAssociation && columnAssociationLabel && columnAssociationLabel !== columnTableLabel) {
      columnPath = `${columnAssociationLabel}.${columnName}`;
    } else if (columnTableLabel) {
      columnPath = `${columnTableLabel}.${columnName}`;
    } else {
      columnPath = `${columnTable}.${columnName}`;
    }

    const newRow = document.createElement('tr');
    newRow.className = 'selected-column-row';
    newRow.draggable = true;
    newRow.dataset.columnName = columnName;
    newRow.dataset.columnTable = columnTable;
    newRow.dataset.columnType = columnType;
    newRow.dataset.columnAssociation = columnAssociation || '';
    newRow.dataset.columnLabel = humanName;
    newRow.dataset.columnFormula = '';
    newRow.dataset.action =
      'dragstart->report-builder#handleDragStart dragover->report-builder#handleDragOver drop->report-builder#handleDrop dragend->report-builder#handleDragEnd';
    newRow.style.cursor = 'grab';

    newRow.innerHTML = `
      <td><i class="fa fa-grip-vertical text-muted me-2"></i></td>
      <td>
        <div class="d-flex align-items-center gap-2">
          <input type="text" class="form-control form-control-sm" value="${humanName}" placeholder="${humanName}" data-action="change->report-builder#updateColumnLabel">
        </div>
      </td>
      <td><small class="text-muted text-nowrap">${columnPath}</small></td>
      <td>
        <div class="d-flex align-items-center justify-content-between gap-1">
          <span class="badge bg-light text-dark border">${columnType}</span>
          <button type="button" class="btn btn-sm btn-outline-secondary" data-action="click->formula-editor#open" title="Add Transformations">
            <i class="fa fa-calculator"></i>
          </button>
        </div>
      </td>
      <td class="text-end">
        <button class="btn btn-sm btn-link text-danger p-0" type="button" data-action="click->report-builder#removeColumnFromSelected" style="text-decoration: none;">
          <i class="fa fa-times"></i>
        </button>
      </td>
    `;

    const emptyRow = this.selectedColumnsListTarget.querySelector('em');
    if (emptyRow) {
      emptyRow.closest('tr').remove();
    }

    this.selectedColumnsListTarget.appendChild(newRow);

    row.remove();
  }

  removeColumnFromSelected(event) {
    event.stopPropagation();
    const row = event.currentTarget.closest('tr');

    row.remove();


    if (
      this.selectedColumnsListTarget.querySelectorAll('.selected-column-row').length === 0
    ) {
      const emptyRow = document.createElement('tr');
      emptyRow.innerHTML = `
        <td class="text-center text-muted" colspan="4">
          <em>Click columns from the left to add them</em>
        </td>
      `;
      this.selectedColumnsListTarget.appendChild(emptyRow);
    }
  }

  handleDragStart(event) {
    this.draggedElement = event.currentTarget;
    event.currentTarget.style.opacity = '0.5';
  }

  handleDragEnd(event) {
    event.currentTarget.style.opacity = '1';
  }

  handleDragOver(event) {
    event.preventDefault();
    const target = event.currentTarget;

    if (this.draggedElement && this.draggedElement !== target) {
      const rect = target.getBoundingClientRect();
      const midpoint = rect.top + rect.height / 2;

      if (event.clientY < midpoint) {
        target.parentNode.insertBefore(this.draggedElement, target);
      } else {
        target.parentNode.insertBefore(this.draggedElement, target.nextSibling);
      }
    }
  }

  handleDrop(event) {
    event.preventDefault();
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

    const dataTypeInput = card.querySelector('input[data-filter-data-type]');
    if (dataTypeInput && columnType) {
      dataTypeInput.value = columnType;
    }

    const typeSelect = card.querySelector('select[name="custom_report[filters][][type]"]');
    if (typeSelect && columnType) {
      let filterTypes = this.filterTypesMapValue[columnType] || this.filterTypesMapValue['string'];

      if (isEnum) {
        filterTypes = [['Enum', 'RadSearch::EnumFilter']];
      } else if (!isForeignKey) {
        filterTypes = filterTypes.filter(filter => filter[1] !== 'RadSearch::SearchFilter');
      }

      if (typeSelect.tomselect) {
        const tomselect = typeSelect.tomselect;
        tomselect.clear();
        tomselect.clearOptions();
        filterTypes.forEach((filter) => {
          tomselect.addOption({ value: filter[1], text: filter[0] });
        });
        tomselect.refreshOptions(false);

        if (filterTypes.length === 1) {
          tomselect.setValue(filterTypes[0][1]);
        }
      } else {
        const placeholderOption = '<option value="">Choose filter type...</option>';
        const optionsHtml = filterTypes
          .map((filter) => `<option value="${filter[1]}">${filter[0]}</option>`)
          .join('');
        typeSelect.innerHTML = placeholderOption + optionsHtml;

        if (filterTypes.length === 1) {
          typeSelect.value = filterTypes[0][1];
        } else {
          typeSelect.value = '';
        }
      }
    }
  }

  updateColumnLabel(event) {
    const input = event.target;
    const row = input.closest('tr');
    row.dataset.columnLabel = input.value;
  }

  submitForm(_event) {
    this.hiddenColumnsConfigTarget.innerHTML = '';

    const selectedRows =
      this.selectedColumnsListTarget.querySelectorAll('.selected-column-row');

    selectedRows.forEach((row, index) => {
      const colName = row.dataset.columnName;
      const table = row.dataset.columnTable;
      const association = row.dataset.columnAssociation;
      const type = row.dataset.columnType;

      // Get custom label from the input field, or use the data attribute, or generate it
      const labelInput = row.querySelector('input[type="text"]');
      const customLabel = labelInput ? labelInput.value : (row.dataset.columnLabel || this.generateLabel(colName));
      const formula = row.dataset.columnFormula || '';

      this.createHiddenInput(`custom_report[columns][${index}][name]`, colName);
      this.createHiddenInput(
        `custom_report[columns][${index}][label]`,
        customLabel
      );

      if (type !== 'rich_text') {
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
    });
  }


  createHiddenInput(name, value) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    this.hiddenColumnsConfigTarget.appendChild(input);
  }

  generateLabel(colName) {
    return colName.replace(/_/g, ' ').replace(/\b\w/g, (letter) => letter.toUpperCase());
  }
}
