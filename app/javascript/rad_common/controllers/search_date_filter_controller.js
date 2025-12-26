import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['startInput', 'endInput', 'rangeInput'];
  static values = { ranges: Object };

  connect() {
    if (this.hasStartInputTarget) {
      this.startInputTarget.addEventListener('change', () => this.clearRangeOnManualChange());
    }
    if (this.hasEndInputTarget) {
      this.endInputTarget.addEventListener('change', () => this.clearRangeOnManualChange());
    }
  }

  setRange(event) {
    event.preventDefault();
    const range = event.currentTarget.dataset.range;
    this.setDateRange(range);
  }

  clearRangeOnManualChange() {
    if (this.hasRangeInputTarget && this.rangeInputTarget.value) {
      this.rangeInputTarget.value = '';
    }
  }

  setDateRange(range) {
    let startDate = '';
    let endDate = '';

    if (range !== 'clear' && this.rangesValue[range]) {
      startDate = this.rangesValue[range].startDate;
      endDate = this.rangesValue[range].endDate;
    }

    if (this.hasStartInputTarget && this.hasEndInputTarget) {
      this.startInputTarget.value = startDate;
      this.endInputTarget.value = endDate;
    }

    if (this.hasRangeInputTarget) {
      this.rangeInputTarget.value = range === 'clear' ? '' : range;
    }
  }
}
