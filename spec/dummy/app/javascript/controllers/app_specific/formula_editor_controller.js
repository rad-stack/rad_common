import { Controller } from '@hotwired/stimulus';
import bootstrap from 'bootstrap';

export default class extends Controller {
  static targets = ['transformsList', 'transformPreview', 'transformSelect', 'addButton', 'columnName', 'modal'];

  static paramConfigs = {
    'UPPER': { label: 'Uppercase', params: [] },
    'LOWER': { label: 'Lowercase', params: [] },
    'TITLECASE': { label: 'Title Case', params: [] },
    'CAPITALIZE': { label: 'Capitalize', params: [] },
    'TRUNCATE': {
      label: 'Truncate',
      params: [
        { name: 'length', label: 'Length', type: 'number', default: 50, col_class: 'col-6' },
        { name: 'suffix', label: 'Suffix', type: 'text', default: '...', col_class: 'col-6' }
      ]
    },
    'CONCAT': {
      label: 'Concatenate',
      params: [
        { name: 'text', label: 'Text to append', type: 'text', default: '', placeholder: 'e.g., \' - Suffix\'' }
      ]
    },
    'REPLACE': {
      label: 'Replace Text',
      params: [
        { name: 'old', label: 'Find', type: 'text', default: '', col_class: 'col-6' },
        { name: 'new', label: 'Replace with', type: 'text', default: '', col_class: 'col-6' }
      ]
    },
    'SUBSTRING': {
      label: 'Substring',
      params: [
        { name: 'start', label: 'Start Position', type: 'number', default: 0, col_class: 'col-6' },
        { name: 'length', label: 'Length', type: 'number', default: 10, col_class: 'col-6' }
      ]
    },
    'ROUND': {
      label: 'Round',
      params: [
        { name: 'precision', label: 'Decimal Places', type: 'number', default: 2 }
      ]
    },
    'ABS': { label: 'Absolute Value', params: [] },
    'MULTIPLY': {
      label: 'Multiply',
      params: [
        { name: 'factor', label: 'Multiply by', type: 'number', default: 1.0, step: 'any' }
      ]
    },
    'DIVIDE': {
      label: 'Divide',
      params: [
        { name: 'divisor', label: 'Divide by', type: 'number', default: 1.0, step: 'any' }
      ]
    },
    'ADD': {
      label: 'Add',
      params: [
        { name: 'amount', label: 'Add Amount', type: 'number', default: 0, step: 'any' }
      ]
    },
    'SUBTRACT': {
      label: 'Subtract',
      params: [
        { name: 'amount', label: 'Subtract Amount', type: 'number', default: 0, step: 'any' }
      ]
    },
    'PERCENT': { label: 'Add Percent Sign', params: [] },
    'AGE': { label: 'Calculate Age', params: [] },
    'DAYS_AGO': { label: 'Days Ago', params: [] },
    'FORMAT_DATE': {
      label: 'Format Date',
      params: [
        {
          name: 'format',
          label: 'Format',
          type: 'select',
          default: '%m/%d/%Y',
          options: [
            ['MM/DD/YYYY', '%m/%d/%Y'],
            ['YYYY-MM-DD', '%Y-%m-%d'],
            ['Month DD, YYYY', '%B %d, %Y'],
            ['MM/DD/YY', '%m/%d/%y']
          ]
        }
      ]
    },
    'BLANK': {
      label: 'Replace if Blank',
      params: [
        { name: 'fallback', label: 'Fallback Value', type: 'text', default: 'N/A' }
      ]
    },
    'YES_NO': { label: 'Yes/No', params: [] }
  };

  connect() {
    this.currentRow = null;
    this.transforms = [];
    this.pendingTransform = null;
    if (this.hasModalTarget) {
      this.modal = new bootstrap.Modal(this.modalTarget);
    }
  }

  open(event) {
    const button = event.currentTarget;
    this.currentRow = button.closest('tr');

    const currentFormula = this.currentRow.dataset.columnFormula || '';
    const columnName = this.currentRow.dataset.columnName || '';
    const columnLabel = this.currentRow.querySelector('input[type="text"]:not([placeholder*="Formula"])')?.value || columnName;

    this.columnNameTarget.textContent = `for "${columnLabel}"`;

    this.transforms = this.parseFormula(currentFormula);
    this.renderTransforms();

    // Reset the dropdown and preview
    this.resetTransformSelection();

    this.modal.show();
  }

  resetTransformSelection() {
    this.transformSelectTarget.value = '';
    this.transformPreviewTarget.innerHTML = '';
    this.pendingTransform = null;
    this.addButtonTarget.style.display = 'none';

    if (this.transformSelectTarget.tomselect) {
      this.transformSelectTarget.tomselect.clear();
    }
  }

  parseFormula(formula) {
    if (!formula) return [];
    try {
      const parsed = JSON.parse(formula);
      if (Array.isArray(parsed)) return parsed;
    } catch { /**/ }

    return [];
  }

  previewTransform() {
    const type = this.transformSelectTarget.value;

    if (!type) {
      this.addButtonTarget.style.display = 'none';
      this.pendingTransform = null;
      return;
    }
    this.pendingTransform = {
      type: type,
      params: this.getDefaultParams(type)
    };
    const paramsHtml = this.renderParamsForPreview(this.pendingTransform);
    this.transformPreviewTarget.innerHTML = paramsHtml;
    this.addButtonTarget.style.display = 'block';
  }

  addTransform() {
    if (!this.pendingTransform) return;

    this.transforms.push({ ...this.pendingTransform });
    this.renderTransforms();

    this.resetTransformSelection();
  }

  getDefaultParams(type) {
    const config = this.constructor.paramConfigs[type];

    if (!config || !config.params || config.params.length === 0) {
      return {};
    }

    // Build default params object from config
    return config.params.reduce((defaults, field) => {
      defaults[field.name] = field.default;
      return defaults;
    }, {});
  }

  renderTransforms() {
    const list = this.transformsListTarget;
    list.innerHTML = this.transforms.map((transform, index) => {
      return this.renderTransform(transform, index);
    }).join('');
  }

  renderTransform(transform, index) {
    const label = this.getTransformLabel(transform.type);
    const paramsHtml = this.renderParams(transform, index);

    return `
      <div class="card mb-2" data-index="${index}">
        <div class="card-body py-2 px-3">
          <div class="d-flex align-items-start gap-2">
            <div class="flex-grow-1">
              <div class="d-flex justify-content-between align-items-center mb-1">
                <strong>${index + 1}. ${label}</strong>
                <button type="button" class="btn btn-sm btn-link text-danger p-0" data-action="click->formula-editor#removeTransform" data-index="${index}">
                  <i class="fa fa-times"></i>
                </button>
              </div>
              ${paramsHtml}
            </div>
          </div>
        </div>
      </div>
    `;
  }

  getTransformLabel(type) {
    const config = this.constructor.paramConfigs[type];
    return config?.label || type;
  }

  renderParams(transform, index) {
    return this.buildParamFields(transform, 'updateParam', index);
  }

  renderParamsForPreview(transform) {
    return this.buildParamFields(transform, 'updatePendingParam');
  }

  buildParamFields(transform, action, index = null) {
    const type = transform.type;
    const params = transform.params;
    const indexAttr = index !== null ? ` data-index="${index}"` : '';
    const actionStr = `change->formula-editor#${action}`;

    const config = this.constructor.paramConfigs[type];
    if (!config || !config.params || config.params.length === 0) {
      return '';
    }

    // Check if we need a row wrapper (multiple columns)
    const hasColumns = config.params.some(field => field.col_class);
    const fields = config.params.map(field => this.buildField(field, params, actionStr, indexAttr)).join('\n');

    if (hasColumns) {
      return `<div class="row g-2">${fields}</div>`;
    }

    return fields;
  }

  buildField(config, params, actionStr, indexAttr) {
    const value = params[config.name] !== undefined ? params[config.name] : config.default;
    const label = `<label class="form-label small mb-1">${config.label}</label>`;

    let input;
    if (config.type === 'select') {
      const options = config.options.map(([label, val]) =>
        `<option value="${val}" ${value === val ? 'selected' : ''}>${label}</option>`
      ).join('\n');
      input = `<select class="form-select form-select-sm" data-action="${actionStr}"${indexAttr} data-param="${config.name}">${options}</select>`;
    } else {
      const stepAttr = config.step ? ` step="${config.step}"` : '';
      const placeholderAttr = config.placeholder ? ` placeholder="${config.placeholder}"` : '';
      input = `<input type="${config.type}" class="form-control form-control-sm" value="${value}"${stepAttr}${placeholderAttr} data-action="${actionStr}"${indexAttr} data-param="${config.name}">`;
    }

    if (config.col_class) {
      return `<div class="${config.col_class}">${label}${input}</div>`;
    }

    return `${label}${input}`;
  }

  updatePendingParam(event) {
    const param = event.target.dataset.param;
    const value = event.target.value;

    if (!this.pendingTransform) return;

    // Convert to number if it's a number input
    const finalValue = event.target.type === 'number' ? parseFloat(value) : value;
    this.pendingTransform.params[param] = finalValue;
  }

  updateParam(event) {
    const index = parseInt(event.target.dataset.index);
    const param = event.target.dataset.param;
    const value = event.target.value;

    if (!this.transforms[index]) return;

    // Convert to number if it's a number input
    const finalValue = event.target.type === 'number' ? parseFloat(value) : value;
    this.transforms[index].params[param] = finalValue;
  }

  removeTransform(event) {
    const index = parseInt(event.target.closest('button').dataset.index);
    this.transforms.splice(index, 1);
    this.renderTransforms();
  }

  saveFormula() {
    if (this.pendingTransform) {
      this.transforms.push({ ...this.pendingTransform });
    }

    if (this.currentRow) {
      const formula = JSON.stringify(this.transforms);
      this.currentRow.dataset.columnFormula = formula;
      this.updateFormulaIndicator(this.currentRow, formula);
    }

    this.modal.hide();
  }

  updateFormulaIndicator(row, formula) {
    const formulaButton = row.querySelector('button[data-action*="formula-editor#open"]');

    if (formulaButton) {
      if (formula && formula !== '[]') {
        formulaButton.classList.add('btn-success');
        formulaButton.classList.remove('btn-outline-secondary');
        formulaButton.title = 'Edit Transformations';
      } else {
        formulaButton.classList.remove('btn-success');
        formulaButton.classList.add('btn-outline-secondary');
        formulaButton.title = 'Add Transformations';
      }
    }
  }
}
