import { Controller } from '@hotwired/stimulus';
import TomSelect from 'tom-select';

export default class extends Controller {
  static targets = ['formulaSelect', 'params', 'columnSelector'];

  connect() {
    this.showSelectedParameters();
    this.initializeColumnSelectors();
  }

  disconnect() {
    this.columnSelectorTargets.forEach((select) => {
      if (select.tomselect) {
        select.tomselect.destroy();
      }
    });
  }

  formulaChanged() {
    this.showSelectedParameters();
  }

  showSelectedParameters() {
    if (!this.hasFormulaSelectTarget) {
      return;
    }

    const selectedFormula = this.formulaSelectTarget.value;

    this.paramsTargets.forEach((element) => {
      const matches = element.dataset.formulaType === selectedFormula && selectedFormula !== '';
      element.hidden = !matches;
      element.classList.toggle('d-none', !matches);
      element.querySelectorAll('input, select, textarea').forEach((field) => {
        field.disabled = !matches;
      });
    });

    this.initializeColumnSelectors();
  }

  initializeColumnSelectors() {
    this.columnSelectorTargets.forEach((select) => {
      if (select.tomselect || select.disabled) {
        return;
      }

      const isMultiple = select.hasAttribute('multiple');

      const config = {
        plugins: isMultiple ? ['remove_button', 'drag_drop'] : ['remove_button'],
        hideSelected: true,
        closeAfterSelect: !isMultiple,
        allowEmptyOption: !isMultiple,
        placeholder: select.querySelector('option[value=""]')?.text || 'Select a column',
      };

      new TomSelect(select, config);
    });
  }
}
