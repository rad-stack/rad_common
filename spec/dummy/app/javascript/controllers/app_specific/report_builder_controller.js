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
    const humanName = this.generateLabel(columnName);

    const newRow = document.createElement('tr');
    newRow.className = 'selected-column-row';
    newRow.draggable = true;
    newRow.dataset.columnName = columnName;
    newRow.dataset.columnTable = columnTable;
    newRow.dataset.columnType = columnType;
    newRow.dataset.action =
      'dragstart->report-builder#handleDragStart dragover->report-builder#handleDragOver drop->report-builder#handleDrop dragend->report-builder#handleDragEnd';
    newRow.style.cursor = 'move';

    newRow.innerHTML = `
      <td><i class="fa fa-grip-vertical text-muted me-2"></i></td>
      <td class="text-truncate" style="width: 60%;">${humanName}</td>
      <td><span class="badge bg-light text-dark border" style="font-size: 0.7rem;">${columnType}</span></td>
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
    const card = select.closest('.filter-card');

    const labelInput = card.querySelector('input[name="custom_report[filters][][label]"]');
    if (labelInput && !labelInput.value && select.value) {
      const columnName = select.value.split('.').pop();
      labelInput.value = this.generateLabel(columnName);
    }

    const typeSelect = card.querySelector('select[name="custom_report[filters][][type]"]');
    if (typeSelect && columnType) {
      const filterTypes = this.filterTypesMapValue[columnType] || this.filterTypesMapValue['string'];

      if (typeSelect.tomselect) {
        const tomselect = typeSelect.tomselect;
        tomselect.clearOptions();
        filterTypes.forEach((filter) => {
          tomselect.addOption({ value: filter[1], text: filter[0] });
        });
        tomselect.refreshOptions(false);
      } else {
        const optionsHtml = filterTypes
          .map((filter) => `<option value="${filter[1]}">${filter[0]}</option>`)
          .join('');
        typeSelect.innerHTML = optionsHtml;
      }
    }
  }

  submitForm(_event) {
    this.hiddenColumnsConfigTarget.innerHTML = '';

    const selectedRows =
      this.selectedColumnsListTarget.querySelectorAll('.selected-column-row');

    selectedRows.forEach((row, index) => {
      const colName = row.dataset.columnName;
      const table = row.dataset.columnTable;
      const type = row.dataset.columnType;

      this.createHiddenInput(`custom_report[columns][${index}][name]`, colName);
      this.createHiddenInput(
        `custom_report[columns][${index}][label]`,
        this.generateLabel(colName)
      );

      if (type !== 'rich_text') {
        this.createHiddenInput(
          `custom_report[columns][${index}][select]`,
          `${table}.${colName}`
        );
      }

      this.createHiddenInput(
        `custom_report[columns][${index}][format]`,
        this.mapTypeToFormat(type)
      );
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

  mapTypeToFormat(type) {
    const typeMapping = {
      integer: 'integer',
      bigint: 'integer',
      decimal: 'decimal',
      float: 'decimal',
      date: 'date',
      datetime: 'datetime',
      timestamp: 'datetime',
      boolean: 'boolean',
      rich_text: 'rich_text'
    };

    return typeMapping[type] || 'string';
  }
}
