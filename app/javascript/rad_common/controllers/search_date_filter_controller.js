import { Controller } from '@hotwired/stimulus';
import moment from 'moment';

export default class extends Controller {
  static targets = ['startInput', 'endInput'];

  setRange(event) {
    event.preventDefault();
    const range = event.currentTarget.dataset.range;
    this.setDateRange(range);
  }

  setDateRange(range) {
    let startDate, endDate;

    switch (range) {
    case 'today':
      startDate = moment();
      endDate = moment();
      break;
    case 'this_week':
      startDate = moment().startOf('week');
      endDate = moment().endOf('week');
      break;
    case 'this_month':
      startDate = moment().startOf('month');
      endDate = moment().endOf('month');
      break;
    case 'this_year':
      startDate = moment().startOf('year');
      endDate = moment().endOf('year');
      break;
    case 'yesterday':
      startDate = moment().subtract(1, 'days');
      endDate = moment().subtract(1, 'days');
      break;
    case 'last_week':
      startDate = moment().subtract(1, 'weeks').startOf('week');
      endDate = moment().subtract(1, 'weeks').endOf('week');
      break;
    case 'last_month':
      startDate = moment().subtract(1, 'months').startOf('month');
      endDate = moment().subtract(1, 'months').endOf('month');
      break;
    case 'last_year':
      startDate = moment().subtract(1, 'years').startOf('year');
      endDate = moment().subtract(1, 'years').endOf('year');
      break;
    case 'clear':
      startDate = null;
      endDate = null;
      break;
    }

    if (this.hasStartInputTarget && this.hasEndInputTarget) {
      this.startInputTarget.value = startDate ? startDate.format('YYYY-MM-DD') : '';
      this.endInputTarget.value = endDate ? endDate.format('YYYY-MM-DD') : '';
    }
  }
}
