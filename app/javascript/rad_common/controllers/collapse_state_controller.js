import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['collapse'];
  static values = {
    enabled: { type: Boolean, default: false },
    storageKey: String
  };

  connect() {
    if (this.enabledValue && this.hasCollapseTarget) {
      this.collapseTarget.style.transition = 'none';
      this.restoreState();
      this.setupEventListeners();
    }
  }

  disconnect() {
    this.removeEventListeners();
  }

  setupEventListeners() {
    try {
      if (this.hasCollapseTarget) {
        this.handleShown = this.handleShown.bind(this);
        this.handleHidden = this.handleHidden.bind(this);

        this.collapseTarget.addEventListener('shown.bs.collapse', this.handleShown);
        this.collapseTarget.addEventListener('hidden.bs.collapse', this.handleHidden);
      }
    } catch { /**/ }
  }

  removeEventListeners() {
    try {
      if (this.hasCollapseTarget && this.handleShown && this.handleHidden) {
        this.collapseTarget.removeEventListener('shown.bs.collapse', this.handleShown);
        this.collapseTarget.removeEventListener('hidden.bs.collapse', this.handleHidden);
      }
    } catch { /**/ }
  }

  handleShown() {
    try {
      localStorage.setItem(this.storageKey(), 'visible');
    } catch { /**/ }
  }

  handleHidden() {
    try {
      localStorage.setItem(this.storageKey(), 'hidden');
    } catch { /**/ }
  }

  restoreState() {
    try {
      const savedState = localStorage.getItem(this.storageKey());
      if (!savedState) return;

      const shouldBeHidden = savedState === 'hidden';
      const isCurrentlyVisible = this.collapseTarget?.classList.contains('show');

      if (shouldBeHidden && isCurrentlyVisible) {
        this.collapseTarget.classList.remove('show');
      } else if (!shouldBeHidden && !isCurrentlyVisible) {
        this.collapseTarget.classList.add('show');
      }
    } catch { /**/ }
  }

  storageKey() {
    return this.storageKeyValue;
  }
}
