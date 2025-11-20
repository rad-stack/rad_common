import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['input', 'label'];

  select(event) {
    event.preventDefault();

    const { matchType, matchTypeLabel } = event.currentTarget.dataset;
    this.inputTarget.value = matchType;
    this.updateFilterDisplay(matchType, matchTypeLabel);
  }

  updateFilterDisplay(type, label) {
    this.labelTarget.textContent = label;

    const items = this.element.querySelectorAll('a.dropdown-item');
    items.forEach(item => {
      const icon = item.querySelector('i.fa-check');

      if (item.dataset.matchType === type) {
        icon?.classList?.remove('d-none');
      } else {
        icon?.classList?.add('d-none');
      }
    });
  }
}
