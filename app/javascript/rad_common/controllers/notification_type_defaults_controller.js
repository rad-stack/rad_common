import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['defaultCheckbox', 'applyToAll', 'applyToAllWrapper'];
  static values = { settingsCount: Number };

  connect() {
    this.originalValues = {};
    this.defaultCheckboxTargets.forEach((checkbox) => {
      this.originalValues[checkbox.name] = checkbox.checked;
    });
  }

  defaultChanged() {
    const changed = this.defaultCheckboxTargets.some(
      (checkbox) => checkbox.checked !== this.originalValues[checkbox.name]
    );

    if (changed) {
      this.applyToAllWrapperTarget.classList.remove('d-none');
    } else {
      this.applyToAllWrapperTarget.classList.add('d-none');
      this.applyToAllTarget.checked = false;
    }
  }

  confirmApplyToAll(event) {
    if (event.target.checked) {
      const count = this.settingsCountValue;
      if (!window.confirm(`Are you sure you want to update ${count} user's settings?`)) {
        event.target.checked = false;
      }
    }
  }
}
